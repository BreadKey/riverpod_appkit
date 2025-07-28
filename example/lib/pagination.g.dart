// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$integerPaginationControllerHash() =>
    r'48852a7d5c408257cc45840baa2d15946f698b6d';

/// See also [IntegerPaginationController].
@ProviderFor(IntegerPaginationController)
final integerPaginationControllerProvider = AutoDisposeNotifierProvider<
    IntegerPaginationController, PagedContent<int>>.internal(
  IntegerPaginationController.new,
  name: r'integerPaginationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$integerPaginationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IntegerPaginationController = AutoDisposeNotifier<PagedContent<int>>;
String _$pageWithParameterControllerHash() =>
    r'c9163e872a747058fe5212d040f40a2552683a4a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PageWithParameterController
    extends BuildlessAutoDisposeNotifier<PagedContent<int>> {
  late final int start;

  PagedContent<int> build({
    required int start,
  });
}

/// See also [PageWithParameterController].
@ProviderFor(PageWithParameterController)
const pageWithParameterControllerProvider = PageWithParameterControllerFamily();

/// See also [PageWithParameterController].
class PageWithParameterControllerFamily extends Family<PagedContent<int>> {
  /// See also [PageWithParameterController].
  const PageWithParameterControllerFamily();

  /// See also [PageWithParameterController].
  PageWithParameterControllerProvider call({
    required int start,
  }) {
    return PageWithParameterControllerProvider(
      start: start,
    );
  }

  @override
  PageWithParameterControllerProvider getProviderOverride(
    covariant PageWithParameterControllerProvider provider,
  ) {
    return call(
      start: provider.start,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pageWithParameterControllerProvider';
}

/// See also [PageWithParameterController].
class PageWithParameterControllerProvider
    extends AutoDisposeNotifierProviderImpl<PageWithParameterController,
        PagedContent<int>> {
  /// See also [PageWithParameterController].
  PageWithParameterControllerProvider({
    required int start,
  }) : this._internal(
          () => PageWithParameterController()..start = start,
          from: pageWithParameterControllerProvider,
          name: r'pageWithParameterControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pageWithParameterControllerHash,
          dependencies: PageWithParameterControllerFamily._dependencies,
          allTransitiveDependencies:
              PageWithParameterControllerFamily._allTransitiveDependencies,
          start: start,
        );

  PageWithParameterControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.start,
  }) : super.internal();

  final int start;

  @override
  PagedContent<int> runNotifierBuild(
    covariant PageWithParameterController notifier,
  ) {
    return notifier.build(
      start: start,
    );
  }

  @override
  Override overrideWith(PageWithParameterController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PageWithParameterControllerProvider._internal(
        () => create()..start = start,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        start: start,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PageWithParameterController,
      PagedContent<int>> createElement() {
    return _PageWithParameterControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PageWithParameterControllerProvider && other.start == start;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, start.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PageWithParameterControllerRef
    on AutoDisposeNotifierProviderRef<PagedContent<int>> {
  /// The parameter `start` of this provider.
  int get start;
}

class _PageWithParameterControllerProviderElement
    extends AutoDisposeNotifierProviderElement<PageWithParameterController,
        PagedContent<int>> with PageWithParameterControllerRef {
  _PageWithParameterControllerProviderElement(super.provider);

  @override
  int get start => (origin as PageWithParameterControllerProvider).start;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
