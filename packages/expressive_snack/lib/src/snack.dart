import 'package:expressive_snack/src/snack_view.dart';
import 'package:material_ui/material_ui.dart';

/// One shown snack and the key that reaches its live view.
class Snack({
  required final String message,
  required final IconData? icon,
  required final Duration duration,
}) {
  final GlobalKey<SnackViewState> key = GlobalKey();
}
