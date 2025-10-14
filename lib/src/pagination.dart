import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

abstract class PagedContentNotifier<T> extends Notifier<PagedContent<T>> {
  @override
  PagedContent<T> build() {
    state = PagedContent<T>();
    init();
    return state;
  }

  /// Initializes the paged content state and triggers initial data loading.
  Future init() async {
    final link = ref.keepAlive();
    await loadMore();
    link.close();
  }

  /// Loads the next page of content.
  Future loadMore() async {
    if (state.isEnd || state.onLoad) return;

    state = state.copyWith(onLoad: true, hasError: false, error: null);
    try {
      final newContents = await loadNextContents(state.contents.lastOrNull);

      state = state.copyWith(
          isEnd: newContents.isEmpty,
          contents: [...state.contents, ...newContents]);
    } catch (e, s) {
      state = state.copyWith(hasError: true, error: e, stackTrace: s);
    } finally {
      state = state.copyWith(onLoad: false);
    }
  }

  /// Loads the next page of content.
  ///
  /// [lastContent] is the last item in the current list of contents, or null if this is the first page.
  /// Returns a [Future] that completes with a list of new items to append.
  ///
  /// This method should be implemented by classes mixing in [PagedContentNotifierMixin].
  /// It will be called automatically by the mixin to load more content when needed.
  ///
  /// The implementation should:
  /// - Use [lastContent] to determine what content to load next (e.g. as a cursor or offset)
  /// - Return an empty list when there is no more content available
  /// - Throw an exception if loading fails, which will be caught and handled by the mixin
  ///
  /// Example implementation:
  /// ```dart
  /// Future<List<Item>> loadNextContents(Item? lastContent) async {
  ///   final offset = lastContent?.id ?? 0;
  ///   final response = await api.getItems(offset: offset, limit: 20);
  ///   return response.items;
  /// }
  /// ```
  ///
  Future<List<T>> loadNextContents(T? lastContent);
}

typedef PagedContentProvider<T>
    = NotifierProvider<PagedContentNotifier<T>, PagedContent<T>>;
typedef PagedContentProviderFamily<T, ArgT> = NotifierProviderFamily<
    PagedContentNotifier<T>, PagedContent<T>, ArgT>;

abstract class PagedContentProviderFactory {
  static PagedContentProvider<T> create<T>(
          PagedContentNotifier<T> Function() create) =>
      NotifierProvider.autoDispose<PagedContentNotifier<T>,
          PagedContent<T>>(() => create());

  static PagedContentProviderFamily<T, ArgT> family<T, ArgT>(
          PagedContentNotifier<T> Function(ArgT arg) create) =>
      NotifierProvider.autoDispose
          .family<PagedContentNotifier<T>, PagedContent<T>, ArgT>(create);
}

@freezed
class PagedContent<T> with _$PagedContent<T> {
  const factory PagedContent(
      {@Default(false) bool onLoad,
      @Default(false) bool isEnd,
      @Default([]) List<T> contents,
      @Default(false) bool hasError,
      Object? error,
      StackTrace? stackTrace}) = _PagedContent;
}

abstract class PagedContentList<T> extends ConsumerWidget {
  final ScrollController? scrollController;
  final bool reverse;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  PagedContentProvider<T> getProvider(BuildContext context, WidgetRef ref);

  const PagedContentList(
      {super.key,
      this.scrollController,
      this.reverse = false,
      this.shrinkWrap = false,
      this.padding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canLoad =
        ref.watch(getProvider(context, ref).select((value) => !value.isEnd));
    final pagedContent = ref.watch(getProvider(context, ref));

    if (pagedContent.hasError) {
      return buildError(
          context, ref, pagedContent.error, pagedContent.stackTrace);
    }

    final contents = getContents(context, ref, pagedContent);

    if (contents.isEmpty) {
      if (canLoad) {
        _loadMore(context, ref);

        return buildLoading(context, ref, false);
      } else {
        return buildEmpty(context, ref);
      }
    }

    return CustomScrollView(
      controller: scrollController,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      slivers: [
        SliverPadding(
          padding: padding ?? EdgeInsets.zero,
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: contents.length + (canLoad ? 1 : 0),
            (context, index) {
              if (canLoad && index == contents.length) {
                return buildLoading(context, ref, true);
              }

              final content = contents[index];
              final isLast = index == contents.length - 1;
              final T? previousContent = index > 0 ? contents[index - 1] : null;
              final T? nextContent =
                  index < contents.length - 1 ? contents[index + 1] : null;

              if (isLast) {
                _loadMore(context, ref);
              }

              return buildContent(
                  context, ref, content, isLast, previousContent, nextContent);
            },
          )),
        )
      ],
    );
  }

  List<T> getContents(
          BuildContext context, WidgetRef ref, PagedContent<T> pagedContent) =>
      pagedContent.contents;

  Widget buildLoading(BuildContext context, WidgetRef ref, bool isListItem);
  Widget buildEmpty(BuildContext context, WidgetRef ref);
  Widget buildError(BuildContext context, WidgetRef ref, Object? error,
      StackTrace? stackTrace);

  void _loadMore(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ref.read(getProvider(context, ref).notifier).loadMore();
      }
    });
  }

  Widget buildContent(BuildContext context, WidgetRef ref, T content,
      bool isLast, T? previousContent, T? nextContent);
}
