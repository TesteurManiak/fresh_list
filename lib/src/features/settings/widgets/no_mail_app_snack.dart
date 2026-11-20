import 'package:fresh_list/src/core/constants/consts.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/widgets/app_snack.dart';
import 'package:material_ui/material_ui.dart';

class const NoMailAppSnack() extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    final strings = context.strings;
    return SnackBarBuilder()
      ..text = strings.no_mail_app(AppConstants.supportEmail)
      ..icon = Icons.mail_outline_rounded;
  }
}
