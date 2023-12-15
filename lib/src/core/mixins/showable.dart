import 'package:flutter/material.dart';

mixin ShowableBottomSheetMixin<T> on Widget {
  Future<T?> show(
    BuildContext context, {
    bool? isDismissible,
    bool? isScrollControlled,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible ?? this.isDismissible,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      builder: (_) => this,
    );
  }

  bool get isDismissible => true;
  bool get isScrollControlled => false;
}
