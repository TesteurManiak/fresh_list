import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class ComingSoonSnack extends AppSnack {
  const new()
    : super(
        // TODO(Guillaume): Add localization
        // Pass the localized message as a parameter.
        message: 'Coming soon — stay tuned!',
        icon: Icons.rocket_launch_rounded,
      );
}
