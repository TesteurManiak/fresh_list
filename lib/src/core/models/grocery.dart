import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery.freezed.dart';

@freezed
class Grocery with _$Grocery {
  const factory Grocery({
    required int id,
    required int order,
    required String name,
    required bool completed,
    double? quantity,
  }) = _Grocery;
}
