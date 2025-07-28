// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PagedContent<T> {
  bool get onLoad => throw _privateConstructorUsedError;
  bool get isEnd => throw _privateConstructorUsedError;
  List<T> get contents => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  /// Create a copy of PagedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagedContentCopyWith<T, PagedContent<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedContentCopyWith<T, $Res> {
  factory $PagedContentCopyWith(
          PagedContent<T> value, $Res Function(PagedContent<T>) then) =
      _$PagedContentCopyWithImpl<T, $Res, PagedContent<T>>;
  @useResult
  $Res call(
      {bool onLoad,
      bool isEnd,
      List<T> contents,
      bool hasError,
      Object? error,
      StackTrace? stackTrace});
}

/// @nodoc
class _$PagedContentCopyWithImpl<T, $Res, $Val extends PagedContent<T>>
    implements $PagedContentCopyWith<T, $Res> {
  _$PagedContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PagedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onLoad = null,
    Object? isEnd = null,
    Object? contents = null,
    Object? hasError = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      onLoad: null == onLoad
          ? _value.onLoad
          : onLoad // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnd: null == isEnd
          ? _value.isEnd
          : isEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<T>,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagedContentImplCopyWith<T, $Res>
    implements $PagedContentCopyWith<T, $Res> {
  factory _$$PagedContentImplCopyWith(_$PagedContentImpl<T> value,
          $Res Function(_$PagedContentImpl<T>) then) =
      __$$PagedContentImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {bool onLoad,
      bool isEnd,
      List<T> contents,
      bool hasError,
      Object? error,
      StackTrace? stackTrace});
}

/// @nodoc
class __$$PagedContentImplCopyWithImpl<T, $Res>
    extends _$PagedContentCopyWithImpl<T, $Res, _$PagedContentImpl<T>>
    implements _$$PagedContentImplCopyWith<T, $Res> {
  __$$PagedContentImplCopyWithImpl(
      _$PagedContentImpl<T> _value, $Res Function(_$PagedContentImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of PagedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onLoad = null,
    Object? isEnd = null,
    Object? contents = null,
    Object? hasError = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$PagedContentImpl<T>(
      onLoad: null == onLoad
          ? _value.onLoad
          : onLoad // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnd: null == isEnd
          ? _value.isEnd
          : isEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      contents: null == contents
          ? _value._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<T>,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$PagedContentImpl<T> implements _PagedContent<T> {
  const _$PagedContentImpl(
      {this.onLoad = false,
      this.isEnd = false,
      final List<T> contents = const [],
      this.hasError = false,
      this.error,
      this.stackTrace})
      : _contents = contents;

  @override
  @JsonKey()
  final bool onLoad;
  @override
  @JsonKey()
  final bool isEnd;
  final List<T> _contents;
  @override
  @JsonKey()
  List<T> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  @override
  @JsonKey()
  final bool hasError;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'PagedContent<$T>(onLoad: $onLoad, isEnd: $isEnd, contents: $contents, hasError: $hasError, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagedContentImpl<T> &&
            (identical(other.onLoad, onLoad) || other.onLoad == onLoad) &&
            (identical(other.isEnd, isEnd) || other.isEnd == isEnd) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      onLoad,
      isEnd,
      const DeepCollectionEquality().hash(_contents),
      hasError,
      const DeepCollectionEquality().hash(error),
      stackTrace);

  /// Create a copy of PagedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedContentImplCopyWith<T, _$PagedContentImpl<T>> get copyWith =>
      __$$PagedContentImplCopyWithImpl<T, _$PagedContentImpl<T>>(
          this, _$identity);
}

abstract class _PagedContent<T> implements PagedContent<T> {
  const factory _PagedContent(
      {final bool onLoad,
      final bool isEnd,
      final List<T> contents,
      final bool hasError,
      final Object? error,
      final StackTrace? stackTrace}) = _$PagedContentImpl<T>;

  @override
  bool get onLoad;
  @override
  bool get isEnd;
  @override
  List<T> get contents;
  @override
  bool get hasError;
  @override
  Object? get error;
  @override
  StackTrace? get stackTrace;

  /// Create a copy of PagedContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagedContentImplCopyWith<T, _$PagedContentImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
