import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery.freezed.dart';

@freezed
abstract class Grocery with _$Grocery {
  const factory({
    required int id,
    required String name,
    @Default(0) int order,
    @Default(false) bool completed,
  }) = _Grocery;
}
