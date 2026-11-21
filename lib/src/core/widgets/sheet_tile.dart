import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class SheetTile extends StatelessWidget {
  const new({
    required this.title,
    this.leading,
    this.selected = false,
    this.borderRadius = .zero,
    this.onTap,
    super.key,
  });

  final String title;
  final Widget? leading;
  final bool selected;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  static const gap = 4.0;
  static const outer = Radius.circular(20);
  static const inner = Radius.circular(6);

  // M3 Expressive outer vs. inner radii + pill morph on selection
  static BorderRadius radiusFor(int index, int length, bool selected) {
    return selected
        ? .circular(28)
        : .vertical(
            top: index == 0 ? outer : inner,
            bottom: index == length - 1 ? outer : inner,
          );
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: selected ? cs.secondaryContainer : cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const .symmetric(horizontal: 20, vertical: 16),
          child: Row(
            spacing: 12,
            children: [
              ?leading,
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.googleSans(
                    textStyle: textTheme.titleMedium,
                    fontWeight: selected ? .w700 : .w500,
                    color: selected ? cs.onSecondaryContainer : cs.onSurface,
                  ),
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle_rounded,
                  color: cs.onSecondaryContainer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
