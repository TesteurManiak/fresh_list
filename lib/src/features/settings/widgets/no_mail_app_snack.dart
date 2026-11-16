import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/constants/consts.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class const NoMailAppSnack() extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    return SnackBarBuilder()
      ..text = 'No mail app. Write to ${AppConstants.supportEmail}'
      ..icon = Icons.mail_outline_rounded;
  }
}
