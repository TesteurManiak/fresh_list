import 'package:material_ui/material_ui.dart';

class AppSheet extends StatelessWidget {
  const new({required this.child, this.backgroundColor, super.key});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const .all(16),
          // Dialog spec: container width is capped at 560dp on larger screens.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Material(
              color: backgroundColor ?? cs.surfaceContainerHigh,
              clipBehavior: .antiAlias,
              shape: RoundedRectangleBorder(
                // M3 concentric nesting: outer radius = inner radius + padding.
                // The stadium buttons inside are 28 (56dp tall) behind 24
                // padding.
                borderRadius: .circular(52),
              ),
              child: Padding(padding: const .all(24), child: child),
            ),
          ),
        ),
      ),
    );
  }
}
