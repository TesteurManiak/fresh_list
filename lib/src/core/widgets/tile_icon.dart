import 'package:material_ui/material_ui.dart';

class TileIcon extends StatelessWidget {
  const new(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFFFDCC2),
        borderRadius: BorderRadius.all(.circular(12)),
      ),
      child: Icon(icon),
    );
  }
}
