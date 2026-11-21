import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class GroceryCard extends StatelessWidget {
  const new({
    super.key,
    required this.name,
    this.leading,
    this.trailing,
    this.completed = false,
    this.borderRadius,
    this.onTap,
    this.onDoubleTap,
  });

  final String name;
  final Widget? leading;
  final Widget? trailing;
  final bool completed;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  static const animationDuration = Duration(milliseconds: 300);
  static const animationCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      clipBehavior: .antiAlias,
      constraints: const BoxConstraints(minHeight: 56, maxHeight: 88),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: completed ? cs.secondaryContainer : cs.surfaceContainer,
      ),
      child: Material(
        type: .transparency,
        child: InkWell(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 12),
            child: IconTheme(
              data: IconThemeData(
                color: completed ? cs.onSecondaryContainer : cs.onSurface,
                size: 24,
              ),
              child: Row(
                spacing: 12,
                children: [
                  ?leading,
                  Expanded(
                    child: Text(
                      name,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: .w400,
                        decoration: completed ? .lineThrough : null,
                        height: 24 / 16,
                        color: completed
                            ? cs.onSecondaryContainer
                            : cs.onSurface,
                      ),
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
