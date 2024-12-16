import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_appkit/riverpod_appkit.dart';

part 'pagination.g.dart';

@riverpod
class IntegerPaginationController extends _$IntegerPaginationController
    with PagedContentControllerMixin<int> {
  @override
  PagedContent<int> build() {
    init(ref);
    return const PagedContent();
  }

  @override
  Future<List<int>> loadNextContents(int? lastContent) async {
    await Future.delayed(const Duration(seconds: 1));

    if (lastContent == null) {
      return List.generate(10, (index) => index);
    }

    return List.generate(10, (index) => lastContent + index + 1);
  }
}
