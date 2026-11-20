import 'package:material_ui/material_ui.dart';

class TileIcon extends StatelessWidget {
  const new(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    return Container(
      padding: const .all(8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: const BorderRadius.all(.circular(12)),
      ),
      child: Icon(icon, color: cs.onSurface),
    );
  }
}
