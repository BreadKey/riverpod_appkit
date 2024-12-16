import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

@freezed
class PagedContent<T> with _$PagedContent<T> {
  const factory PagedContent(
      {@Default(false) bool onLoad,
      @Default(false) bool isEnd,
      @Default([]) List<T> contents,
      @Default(false) bool hasError,
      Object? error}) = _PagedContent;
}

mixin PagedContentControllerMixin<T> {
  PagedContent<T> get state;
  set state(PagedContent<T> value);

  Future init(Ref ref) async {
    final link = ref.keepAlive();
    await _loadMore();
    link.close();
  }

  Future _loadMore() async {
    if (state.isEnd || state.onLoad) return;

    state = state.copyWith(onLoad: true, hasError: false, error: null);
    try {
      final newContents = await loadMore(state.contents.lastOrNull);

      state = state.copyWith(
          isEnd: newContents.isEmpty,
          contents: [...state.contents, ...newContents]);
    } catch (e) {
      state = state.copyWith(hasError: true, error: e);
    } finally {
      state = state.copyWith(onLoad: false);
    }
  }

  /// Loads the next page of content.
  ///
  /// [lastItem] is the last item in the current list of contents, or null if this is the first page.
  /// Returns a [Future] that completes with a list of new items to append.
  ///
  /// This method should be implemented by classes mixing in [PagedContentControllerMixin].
  /// It will be called automatically by the mixin to load more content when needed.
  ///
  /// The implementation should:
  /// - Use [lastItem] to determine what content to load next
  /// - Return an empty list when there is no more content
  /// - Throw an exception if loading fails, which will be caught by the mixin
  ///
  Future<List<T>> loadMore(T? lastItem);
}

abstract class PagedContentList<T> extends ConsumerWidget {
  final ScrollController? scrollController;
  final bool reverse;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  Refreshable<PagedContent<T>> getProvider(BuildContext context, WidgetRef ref);

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
      return buildError(context, ref, pagedContent.error);
    }

    final contents = getContents(context, ref, pagedContent);

    if (contents.isEmpty) {
      if (canLoad) {
        _loadMore(context, ref);

        return buildLoading(context, ref);
      } else {
        return buildEmpty(context, ref);
      }
    }

    return ListView.builder(
      controller: scrollController,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: contents.length + (canLoad ? 1 : 0),
      itemBuilder: (context, index) {
        if (canLoad && index == contents.length) {
          return buildLoading(context, ref);
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
    );
  }

  List<T> getContents(
          BuildContext context, WidgetRef ref, PagedContent<T> pagedContent) =>
      pagedContent.contents;

  Widget buildLoading(BuildContext context, WidgetRef ref);
  Widget buildEmpty(BuildContext context, WidgetRef ref);
  Widget buildError(BuildContext context, WidgetRef ref, Object? error);

  void _loadMore(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMore(context, ref);
    });
  }

  void loadMore(BuildContext context, WidgetRef ref);

  Widget buildContent(BuildContext context, WidgetRef ref, T content,
      bool isLast, T? previousContent, T? nextContent);
}