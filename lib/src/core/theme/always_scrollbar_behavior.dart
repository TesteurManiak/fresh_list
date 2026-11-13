import 'package:material_ui/material_ui.dart';

class const AlwaysScrollbarBehavior() extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (axisDirectionToAxis(details.direction) == .horizontal) return child;
    return Scrollbar(controller: details.controller, child: child);
  }
}
