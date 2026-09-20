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

 int get id; String get name; int get order; bool get completed;
/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroceryCopyWith<Grocery> get copyWith => _$GroceryCopyWithImpl<Grocery>(this as Grocery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Grocery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Grocery&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.completed, _this.completed) || other.completed == _this.completed));
}


@override
int get hashCode {
  final _this = this as Grocery;
  return Object.hash(runtimeType,_this.id,_this.name,_this.order,_this.completed);
}

@override
String toString() {
  final _this = this as Grocery;
  return 'Grocery(id: ${_this.id}, name: ${_this.name}, order: ${_this.order}, completed: ${_this.completed})';
}


}

/// @nodoc
abstract mixin class $GroceryCopyWith<$Res>  {
  factory $GroceryCopyWith(Grocery value, $Res Function(Grocery) _then) = _$GroceryCopyWithImpl;
@useResult
$Res call({
 int id, String name, int order, bool completed
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,Object? completed = null,}) {
  return _then(Grocery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _Grocery implements Grocery {
  const _Grocery({required this.id, required this.name, this.order = 0, this.completed = false});
  

@override final  int id;
@override final  String name;
@override@JsonKey() final  int order;
@override@JsonKey() final  bool completed;

/// Create a copy of Grocery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroceryCopyWith<_Grocery> get copyWith => __$GroceryCopyWithImpl<_Grocery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Grocery&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,order,completed);
}

@override
String toString() {
    return 'Grocery(id: $id, name: $name, order: $order, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$GroceryCopyWith<$Res> implements $GroceryCopyWith<$Res> {
  factory _$GroceryCopyWith(_Grocery value, $Res Function(_Grocery) _then) = __$GroceryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int order, bool completed
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,Object? completed = null,}) {
  return _then(_Grocery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
