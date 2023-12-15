// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'grocery.dart';

class GroceryMapper extends ClassMapperBase<Grocery> {
  GroceryMapper._();

  static GroceryMapper? _instance;
  static GroceryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GroceryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Grocery';

  static int _$index(Grocery v) => v.index;
  static const Field<Grocery, int> _f$index = Field('index', _$index);
  static String _$name(Grocery v) => v.name;
  static const Field<Grocery, String> _f$name = Field('name', _$name);
  static DateTime _$createdAt(Grocery v) => v.createdAt;
  static const Field<Grocery, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static double? _$quantity(Grocery v) => v.quantity;
  static const Field<Grocery, double> _f$quantity =
      Field('quantity', _$quantity, opt: true);
  static int? _$id(Grocery v) => v.id;
  static const Field<Grocery, int> _f$id =
      Field('id', _$id, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<Grocery, dynamic>> fields = const {
    #index: _f$index,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #quantity: _f$quantity,
    #id: _f$id,
  };

  static Grocery _instantiate(DecodingData data) {
    return Grocery(
        index: data.dec(_f$index),
        name: data.dec(_f$name),
        createdAt: data.dec(_f$createdAt),
        quantity: data.dec(_f$quantity));
  }

  @override
  final Function instantiate = _instantiate;

  static Grocery fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Grocery>(map);
  }

  static Grocery fromJson(String json) {
    return ensureInitialized().decodeJson<Grocery>(json);
  }
}

mixin GroceryMappable {
  String toJson() {
    return GroceryMapper.ensureInitialized()
        .encodeJson<Grocery>(this as Grocery);
  }

  Map<String, dynamic> toMap() {
    return GroceryMapper.ensureInitialized()
        .encodeMap<Grocery>(this as Grocery);
  }

  GroceryCopyWith<Grocery, Grocery, Grocery> get copyWith =>
      _GroceryCopyWithImpl(this as Grocery, $identity, $identity);
  @override
  String toString() {
    return GroceryMapper.ensureInitialized().stringifyValue(this as Grocery);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GroceryMapper.ensureInitialized()
                .isValueEqual(this as Grocery, other));
  }

  @override
  int get hashCode {
    return GroceryMapper.ensureInitialized().hashValue(this as Grocery);
  }
}

extension GroceryValueCopy<$R, $Out> on ObjectCopyWith<$R, Grocery, $Out> {
  GroceryCopyWith<$R, Grocery, $Out> get $asGrocery =>
      $base.as((v, t, t2) => _GroceryCopyWithImpl(v, t, t2));
}

abstract class GroceryCopyWith<$R, $In extends Grocery, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? index, String? name, DateTime? createdAt, double? quantity});
  GroceryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GroceryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Grocery, $Out>
    implements GroceryCopyWith<$R, Grocery, $Out> {
  _GroceryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Grocery> $mapper =
      GroceryMapper.ensureInitialized();
  @override
  $R call(
          {int? index,
          String? name,
          DateTime? createdAt,
          Object? quantity = $none}) =>
      $apply(FieldCopyWithData({
        if (index != null) #index: index,
        if (name != null) #name: name,
        if (createdAt != null) #createdAt: createdAt,
        if (quantity != $none) #quantity: quantity
      }));
  @override
  Grocery $make(CopyWithData data) => Grocery(
      index: data.get(#index, or: $value.index),
      name: data.get(#name, or: $value.name),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      quantity: data.get(#quantity, or: $value.quantity));

  @override
  GroceryCopyWith<$R2, Grocery, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GroceryCopyWithImpl($value, $cast, t);
}
