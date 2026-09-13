// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Grocery {

 int get id; int get order; String get name; bool get completed; GroceryQuantityUnit get quantityUnit; int? get quantity;
/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroceryCopyWith<Grocery> get copyWith => _$GroceryCopyWithImpl<Grocery>(this as Grocery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Grocery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Grocery&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.completed, _this.completed) || other.completed == _this.completed)&&(identical(other.quantityUnit, _this.quantityUnit) || other.quantityUnit == _this.quantityUnit)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity));
}


@override
int get hashCode {
  final _this = this as Grocery;
  return Object.hash(runtimeType,_this.id,_this.order,_this.name,_this.completed,_this.quantityUnit,_this.quantity);
}

@override
String toString() {
  final _this = this as Grocery;
  return 'Grocery(id: ${_this.id}, order: ${_this.order}, name: ${_this.name}, completed: ${_this.completed}, quantityUnit: ${_this.quantityUnit}, quantity: ${_this.quantity})';
}


}

/// @nodoc
abstract mixin class $GroceryCopyWith<$Res>  {
  factory $GroceryCopyWith(Grocery value, $Res Function(Grocery) _then) = _$GroceryCopyWithImpl;
@useResult
$Res call({
 int id, int order, String name, bool completed, GroceryQuantityUnit quantityUnit, int? quantity
});




}
/// @nodoc
class _$GroceryCopyWithImpl<$Res>
    implements $GroceryCopyWith<$Res> {
  _$GroceryCopyWithImpl(this._self, this._then);

  final Grocery _self;
  final $Res Function(Grocery) _then;

/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? name = null,Object? completed = null,Object? quantityUnit = null,Object? quantity = freezed,}) {
  return _then(Grocery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: null == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as GroceryQuantityUnit,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Grocery].
extension GroceryPatterns on Grocery {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Grocery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Grocery() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Grocery value)  $default,){
final _that = this;
switch (_that) {
case _Grocery():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Grocery value)?  $default,){
final _that = this;
switch (_that) {
case _Grocery() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int order,  String name,  bool completed,  GroceryQuantityUnit quantityUnit,  int? quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Grocery() when $default != null:
return $default(_that.id,_that.order,_that.name,_that.completed,_that.quantityUnit,_that.quantity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int order,  String name,  bool completed,  GroceryQuantityUnit quantityUnit,  int? quantity)  $default,) {final _that = this;
switch (_that) {
case _Grocery():
return $default(_that.id,_that.order,_that.name,_that.completed,_that.quantityUnit,_that.quantity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int order,  String name,  bool completed,  GroceryQuantityUnit quantityUnit,  int? quantity)?  $default,) {final _that = this;
switch (_that) {
case _Grocery() when $default != null:
return $default(_that.id,_that.order,_that.name,_that.completed,_that.quantityUnit,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc


class _Grocery extends Grocery {
  const _Grocery({required this.id, required this.order, required this.name, required this.completed, this.quantityUnit = GroceryQuantityUnit.piece, this.quantity}): super._();
  

@override final  int id;
@override final  int order;
@override final  String name;
@override final  bool completed;
@override@JsonKey() final  GroceryQuantityUnit quantityUnit;
@override final  int? quantity;

/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroceryCopyWith<_Grocery> get copyWith => __$GroceryCopyWithImpl<_Grocery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Grocery&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.name, name) || other.name == name)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.quantityUnit, quantityUnit) || other.quantityUnit == quantityUnit)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,order,name,completed,quantityUnit,quantity);
}

@override
String toString() {
    return 'Grocery(id: $id, order: $order, name: $name, completed: $completed, quantityUnit: $quantityUnit, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$GroceryCopyWith<$Res> implements $GroceryCopyWith<$Res> {
  factory _$GroceryCopyWith(_Grocery value, $Res Function(_Grocery) _then) = __$GroceryCopyWithImpl;
@override @useResult
$Res call({
 int id, int order, String name, bool completed, GroceryQuantityUnit quantityUnit, int? quantity
});




}
/// @nodoc
class __$GroceryCopyWithImpl<$Res>
    implements _$GroceryCopyWith<$Res> {
  __$GroceryCopyWithImpl(this._self, this._then);

  final _Grocery _self;
  final $Res Function(_Grocery) _then;

/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? name = null,Object? completed = null,Object? quantityUnit = null,Object? quantity = freezed,}) {
  return _then(_Grocery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,quantityUnit: null == quantityUnit ? _self.quantityUnit : quantityUnit // ignore: cast_nullable_to_non_nullable
as GroceryQuantityUnit,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
