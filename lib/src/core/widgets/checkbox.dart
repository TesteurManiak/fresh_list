import 'package:material_ui/material_ui.dart';

class AppCheckbox extends StatelessWidget {
  const new({
    required this.value,
    required this.onChanged,
    this.size = 28,
    this.semanticLabel,
    super.key,
  });

  final bool value;
  final double size;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Semantics(
      label: semanticLabel,
      checked: value,
      child: GestureDetector(
        onTap: () => onChanged?.call(!value),
        child: AnimatedContainer(
          duration: kRadialReactionDuration,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: value ? cs.primary : Colors.transparent,
            border: Border.all(
              color: value ? cs.primary : cs.outline,
              width: 2,
            ),
            borderRadius: .circular(8),
          ),
          child: value
              ? Icon(Icons.check, size: 18, color: cs.onPrimary)
              : null,
        ),
      ),
    );
  }
}
