import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/constants/consts.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class const NoMailAppSnack() extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    final strings = context.strings;
    return SnackBarBuilder()
      ..text = strings.no_mail_app(AppConstants.supportEmail)
      ..icon = Icons.mail_outline_rounded;
  }
}
