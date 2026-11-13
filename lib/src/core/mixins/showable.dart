import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/widgets/expressive_sheet.dart';

mixin ShowableBottomSheetMixin<T> on Widget {
  Future<T?> show(BuildContext context) {
    return showExpressiveSheet<T>(context: context, builder: (_) => this);
  }
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
