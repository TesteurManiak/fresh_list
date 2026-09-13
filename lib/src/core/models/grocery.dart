import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/src/core/formatters/quantity_formatter.dart';

part 'grocery.freezed.dart';

@freezed
abstract class Grocery with _$Grocery {
  const new _();

  const factory({
    required int id,
    required int order,
    required String name,
    required bool completed,
    @Default(GroceryQuantityUnit.piece) GroceryQuantityUnit quantityUnit,
    int? quantity,
  }) = _Grocery;

  String formatQuantity(QuantityFormatter formatter) {
    final quantity = this.quantity ?? 0;
    if (quantity <= 0) return '';
    return quantityUnit.formatter(formatter, quantity);
  }
}

typedef QuantityStringFormatter = String Function(
  QuantityFormatter formatter,
  int quantity,
);

enum GroceryQuantityUnit(final QuantityStringFormatter formatter) {
  piece(_piece),
  gram(_gram),
  liter(_liter);

  static String _piece(QuantityFormatter formatter, int quantity) =>
      formatter.formatPieces(quantity);

  static String _gram(QuantityFormatter formatter, int quantity) =>
      formatter.formatGrams(quantity);

  static String _liter(QuantityFormatter formatter, int quantity) =>
      formatter.formatLiters(quantity);
}
