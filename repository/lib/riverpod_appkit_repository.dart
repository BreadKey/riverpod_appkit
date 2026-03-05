import 'package:riverpod/riverpod.dart';
import 'package:riverpod_appkit/riverpod_appkit.dart';

abstract interface class PagingRepository<T> {
  Future<List<T>> load(int count, {String? afterId});
}

abstract class PagedContentController<T extends PagingModel>
    extends PagedContentNotifier<T> {
  final bool needToListenNewContents;

  PagedContentController({required this.needToListenNewContents});

  @override
  Future init() async {
    await super.init();
    if (needToListenNewContents) {
      listenNewContents(ref);
    }
  }

  @override
  Future<List<T>> loadNextContents(T? lastContent) async {
    final id = lastContent == null ? null : getId(lastContent);
    final repository = getRepository();

    return await repository.load(10, afterId: id);
  }

  String? getId(T content) {
    return content.id;
  }

  PagingRepository<T> getRepository();

  void listenNewContents(Ref ref) {
    final changes = getChanges();
    final subscription = changes.listen((event) {
      addContent(event);
    });
    ref.onDispose(() {
      subscription.cancel();
    });
  }

  Stream<T> getChanges();

  void addContent(T content, {bool updateState = true}) {
    final contents = [...state.contents];
    final index = contents.indexWhere(
      (element) => getId(element) == getId(content),
    );

    if (index == -1) {
      if ((!state.onLoad && contents.isEmpty) ||
          isNewContent(content, getLatestContent())) {
        insertNewContent(content, contents);
      }
    } else {
      updateContent(content, contents, index, updateState);
    }
  }

  T? getLatestContent() {
    return state.contents.firstOrNull;
  }

  bool isNewContent(T content, T? latestContent);

  void insertNewContent(T content, List<T> contents) {
    state = state.copyWith(contents: [content, ...contents]);
  }

  void updateContent(T content, List<T> contents, int index, bool updateState) {
    final isUpdated = contents[index] != content;

    contents[index] = content;

    if (isUpdated) {
      if (updateState) {
        if (isNewContent(content, getLatestContent())) {
          contents.removeAt(index);
          contents.insert(0, content);
        }

        state = state.copyWith(contents: contents);
      }
    }
  }
}
