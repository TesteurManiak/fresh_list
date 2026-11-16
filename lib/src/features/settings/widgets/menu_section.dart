import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class MenuSection extends StatelessWidget {
  const new({required this.children, this.label, super.key});

  final String? label;
  final List<Widget> children;

  static const double outerRadius = 28;
  static const double innerRadius = 4;
  static const double tileGap = 2;

  static BorderRadius radiusFor(int index, int length) {
    const Radius outer = .circular(outerRadius);
    const Radius inner = .circular(innerRadius);

    return .vertical(
      top: index == 0 ? outer : inner,
      bottom: index == length - 1 ? outer : inner,
    );
  }

  static BorderRadius? radiusOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SectionPosition>()
        ?.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        if (label case final label?)
          Padding(
            padding: const .fromLTRB(16, 0, 16, 12),
            child: Text(
              label,
              style: GoogleFonts.unbounded(
                textStyle: textTheme.labelLarge,
                fontWeight: .w600,
                letterSpacing: -.3,
                color: colorScheme.primary,
              ),
            ),
          ),
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(height: tileGap),
          _SectionPosition(
            borderRadius: radiusFor(i, children.length),
            child: children[i],
          ),
        ],
      ],
    );
  }
}

class _SectionPosition extends InheritedWidget {
  const new({required this.borderRadius, required super.child});

  final BorderRadius borderRadius;

  @override
  bool updateShouldNotify(_SectionPosition old) =>
      old.borderRadius != borderRadius;
}
