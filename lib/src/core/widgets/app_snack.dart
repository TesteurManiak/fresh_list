import 'package:expressive_snack/expressive_snack.dart';
import 'package:material_ui/material_ui.dart';

abstract class const AppSnack({
  required final String message,
  final IconData? icon,
  final Duration duration = const Duration(seconds: 4),
}) {
  void show(BuildContext context) => showExpressiveSnack(
    context: context,
    message: message,
    icon: icon,
    duration: duration,
  );
}
