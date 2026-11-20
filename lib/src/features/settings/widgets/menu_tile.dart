import 'package:fresh_list/src/features/settings/widgets/menu_section.dart';
import 'package:material_ui/material_ui.dart';

/// A single row in a grouped settings list. Sized to the M3 list-item spec:
/// 56dp min height for one line, 72dp with a supporting line, 24dp leading
/// icon, 16dp horizontal padding. Corner radii are assigned by [MenuSection]
/// based on the tile's position within its group.
class MenuTile extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.background,
    this.foreground,
    this.borderRadius,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? background;
  final Color? foreground;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    final tt = TextTheme.of(context);

    final titleColor = foreground ?? cs.onSurface;
    final accessoryColor = foreground ?? cs.onSurfaceVariant;

    return Material(
      color: background ?? cs.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ??
            MenuSection.radiusOf(context) ??
            .circular(MenuSection.innerRadius),
      ),
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: subtitle == null ? 56 : 72),
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon, size: 24, color: accessoryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(
                        title,
                        style: tt.bodyLarge?.copyWith(color: titleColor),
                      ),
                      if (subtitle case final s?)
                        Text(
                          s,
                          style: tt.bodyMedium?.copyWith(color: accessoryColor),
                        ),
                    ],
                  ),
                ),
                if (trailing case final t?) ...[
                  const SizedBox(width: 8),
                  t,
                ] else if (onTap != null) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right_rounded, color: accessoryColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
