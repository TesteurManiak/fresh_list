import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';

final quantityFormatterProvider = Provider<QuantityFormatter>((ref) {
  final locale = ref.watch(localeControllerProvider);
  return QuantityFormatter(locale);
});

class const QuantityFormatter(final Locale locale) {
  String formatPieces(int pieces) => 'x$pieces';

  String formatGrams(int grams, {int decimalDigits = 1}) {
    if (grams < 1000) return '${grams}g';

    final kilograms = grams / 1000;

    final formatter = NumberFormat.decimalPattern(locale.toString())
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = decimalDigits;
    return '${formatter.format(kilograms)}kg';
  }

  String formatLiters(int centiliters, {int decimalDigits = 1}) {
    if (centiliters < 100) return '${centiliters}cL';

    final liters = centiliters / 100;

    final formatter = NumberFormat.decimalPattern(locale.toString())
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = decimalDigits;
    return '${formatter.format(liters)}L';
  }
}
