import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class ErrorSnack(final Object error) extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    return SnackBarBuilder()
      ..text = error.toString()
      ..icon = Icons.error_outline;
  }
}
