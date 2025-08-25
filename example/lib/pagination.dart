import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_appkit/riverpod_appkit.dart';

part 'pagination.g.dart';

@riverpod
class IntegerPaginationController extends _$IntegerPaginationController
    with PagedContentControllerMixin<int> {
  @override
  PagedContent<int> build() {
    return doBuild(ref);
  }

  @override
  Future<List<int>> loadNextContents(int? lastContent) async {
    await Future.delayed(const Duration(seconds: 2));

    if (lastContent == null) {
      return List.generate(3, (index) => index);
    }


    return List.generate(3, (index) => lastContent + index + 1);
  }
}

@riverpod
class PageWithParameterController extends _$PageWithParameterController
    with PagedContentControllerMixin<int> {
  @override
  PagedContent<int> build({required int start}) {
    return doBuild(ref);
  }

  @override
  Future<List<int>> loadNextContents(int? lastContent) async {
    await Future.delayed(const Duration(seconds: 1));

    if (lastContent == null) {
      return List.generate(10, (index) => start + index);
    }

    return List.generate(10, (index) => lastContent + index + 1);
  }
}
