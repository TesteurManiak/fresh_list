import 'package:flutter/material.dart';

mixin ShowableBottomSheetMixin<T> on Widget {
  Future<T?> show(
    BuildContext context, {
    bool? isDismissible,
    bool? isScrollControlled,
    bool? showDragHandle,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible ?? this.isDismissible,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      showDragHandle: showDragHandle ?? this.showDragHandle,
      useSafeArea: true,
      builder: (_) => this,
    );
  }

  bool get isDismissible => true;
  bool get isScrollControlled => false;
  bool get showDragHandle => false;
}

mixin ShowableDialogMixin<T> on Widget {
  Future<T?> show(BuildContext context, {bool? barrierDismissible}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      builder: (_) => this,
    );
  }

  bool get barrierDismissible => true;
}
