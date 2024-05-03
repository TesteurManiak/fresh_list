// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Grocery {
  int get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroceryCopyWith<Grocery> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryCopyWith<$Res> {
  factory $GroceryCopyWith(Grocery value, $Res Function(Grocery) then) =
      _$GroceryCopyWithImpl<$Res, Grocery>;
  @useResult
  $Res call({int id, int order, String name, bool completed, double? quantity});
}

/// @nodoc
class _$GroceryCopyWithImpl<$Res, $Val extends Grocery>
    implements $GroceryCopyWith<$Res> {
  _$GroceryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? name = null,
    Object? completed = null,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroceryImplCopyWith<$Res> implements $GroceryCopyWith<$Res> {
  factory _$$GroceryImplCopyWith(
          _$GroceryImpl value, $Res Function(_$GroceryImpl) then) =
      __$$GroceryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int order, String name, bool completed, double? quantity});
}

/// @nodoc
class __$$GroceryImplCopyWithImpl<$Res>
    extends _$GroceryCopyWithImpl<$Res, _$GroceryImpl>
    implements _$$GroceryImplCopyWith<$Res> {
  __$$GroceryImplCopyWithImpl(
      _$GroceryImpl _value, $Res Function(_$GroceryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? name = null,
    Object? completed = null,
    Object? quantity = freezed,
  }) {
    return _then(_$GroceryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$GroceryImpl implements _Grocery {
  const _$GroceryImpl(
      {required this.id,
      required this.order,
      required this.name,
      required this.completed,
      this.quantity});

  @override
  final int id;
  @override
  final int order;
  @override
  final String name;
  @override
  final bool completed;
  @override
  final double? quantity;

  @override
  String toString() {
    return 'Grocery(id: $id, order: $order, name: $name, completed: $completed, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, order, name, completed, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryImplCopyWith<_$GroceryImpl> get copyWith =>
      __$$GroceryImplCopyWithImpl<_$GroceryImpl>(this, _$identity);
}

abstract class _Grocery implements Grocery {
  const factory _Grocery(
      {required final int id,
      required final int order,
      required final String name,
      required final bool completed,
      final double? quantity}) = _$GroceryImpl;

  @override
  int get id;
  @override
  int get order;
  @override
  String get name;
  @override
  bool get completed;
  @override
  double? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$GroceryImplCopyWith<_$GroceryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
