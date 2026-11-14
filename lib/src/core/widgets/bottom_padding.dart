import 'package:material_ui/material_ui.dart';

class BottomPadding extends StatelessWidget {
  const new({super.key});

  static double of(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context).bottom;
    final height = viewPadding > 0 ? viewPadding : 16.0;

    return height;
  }

  @override
  Widget build(BuildContext context) {
    final double height = of(context);
    return SizedBox(height: height);
  }
}
