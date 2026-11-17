import 'package:material_ui/material_ui.dart';
import 'package:todo_list/gen/assets.gen.dart';

class AppIcon extends StatelessWidget {
  const new({super.key, this.size = 48, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppAssets.iconsSvgPrecompiledIcLauncherMonochromeSvg.svg(
      width: size,
      height: size,
      colorFilter: color?.toColorFilter(),
    );
  }
}

extension on Color {
  ColorFilter toColorFilter() => ColorFilter.mode(this, .srcIn);
}
