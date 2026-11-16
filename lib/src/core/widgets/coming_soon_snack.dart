import 'package:material_ui/material_ui.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class const ComingSoonSnack() extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SnackBarBuilder()
      ..text = strings.coming_soon
      ..icon = Icons.rocket_launch_rounded;
  }
}
