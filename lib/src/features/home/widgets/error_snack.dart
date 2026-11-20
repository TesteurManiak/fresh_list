import 'package:fresh_list/src/core/widgets/app_snack.dart';
import 'package:material_ui/material_ui.dart';

class ErrorSnack(final Object error) extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    return SnackBarBuilder()
      ..text = error.toString()
      ..icon = Icons.error_outline;
  }
}
