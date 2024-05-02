// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecentSearch {
  String get query => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentSearchCopyWith<RecentSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentSearchCopyWith<$Res> {
  factory $RecentSearchCopyWith(
          RecentSearch value, $Res Function(RecentSearch) then) =
      _$RecentSearchCopyWithImpl<$Res, RecentSearch>;
  @useResult
  $Res call({String query, DateTime timestamp});
}

/// @nodoc
class _$RecentSearchCopyWithImpl<$Res, $Val extends RecentSearch>
    implements $RecentSearchCopyWith<$Res> {
  _$RecentSearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentSearchImplCopyWith<$Res>
    implements $RecentSearchCopyWith<$Res> {
  factory _$$RecentSearchImplCopyWith(
          _$RecentSearchImpl value, $Res Function(_$RecentSearchImpl) then) =
      __$$RecentSearchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, DateTime timestamp});
}

/// @nodoc
class __$$RecentSearchImplCopyWithImpl<$Res>
    extends _$RecentSearchCopyWithImpl<$Res, _$RecentSearchImpl>
    implements _$$RecentSearchImplCopyWith<$Res> {
  __$$RecentSearchImplCopyWithImpl(
      _$RecentSearchImpl _value, $Res Function(_$RecentSearchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? timestamp = null,
  }) {
    return _then(_$RecentSearchImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$RecentSearchImpl implements _RecentSearch {
  const _$RecentSearchImpl({required this.query, required this.timestamp});

  @override
  final String query;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'RecentSearch(query: $query, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentSearchImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentSearchImplCopyWith<_$RecentSearchImpl> get copyWith =>
      __$$RecentSearchImplCopyWithImpl<_$RecentSearchImpl>(this, _$identity);
}

abstract class _RecentSearch implements RecentSearch {
  const factory _RecentSearch(
      {required final String query,
      required final DateTime timestamp}) = _$RecentSearchImpl;

  @override
  String get query;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$RecentSearchImplCopyWith<_$RecentSearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
