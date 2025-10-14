import 'package:riverpod_appkit/riverpod_appkit.dart';

final integerPaginationControllerProvider =
    PagedContentProviderFactory.create<IntegerPaginationController, int>(
        IntegerPaginationController.new);

class IntegerPaginationController extends PagedContentNotifier<int> {
  @override
  Future<List<int>> loadNextContents(int? lastContent) async {
    await Future.delayed(const Duration(seconds: 2));

    if (lastContent == null) {
      return List.generate(3, (index) => index);
    }

    return List.generate(3, (index) => lastContent + index + 1);
  }
}

final pageWithParameterControllerProvider =
    PagedContentProviderFactory.family<PageWithParameterController, int, int>(
        (int start) => PageWithParameterController(start: start));

class PageWithParameterController extends PagedContentNotifier<int> {
  final int start;

  PageWithParameterController({required this.start});

  @override
  Future<List<int>> loadNextContents(int? lastContent) async {
    await Future.delayed(const Duration(seconds: 1));

    if (lastContent == null) {
      return List.generate(10, (index) => start + index);
    }

    return List.generate(10, (index) => lastContent + index + 1);
  }
}
