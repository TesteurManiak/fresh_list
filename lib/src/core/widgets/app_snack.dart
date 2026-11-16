import 'package:expressive_snack/expressive_snack.dart';
import 'package:material_ui/material_ui.dart';

abstract class const AppSnack() {
  SnackBarBuilder build(BuildContext context);

  void show(BuildContext context) {
    final builder = build(context);
    final (:message, :icon, :duration) = builder.build();

    return showExpressiveSnack(
      context: context,
      message: message,
      icon: icon,
      duration: duration,
    );
  }
}

typedef Snack = ({String message, IconData? icon, Duration duration});

class SnackBarBuilder() {
  String _text = '';
  IconData? _icon;
  Duration _duration = const Duration(seconds: 4);

  set text(String t) => _text = t;
  set icon(IconData i) => _icon = i;
  set duration(Duration d) => _duration = d;

  Snack build() => (message: _text, icon: _icon, duration: _duration);
}
