import 'package:material_ui/material_ui.dart';

class AppIcon extends StatelessWidget {
  const new({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.shopping_cart, size: size);
  }
}
