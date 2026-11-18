import 'package:material_ui/material_ui.dart';

class AppCheckbox extends StatefulWidget {
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
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool previousValue = widget.value;

  @override
  void didUpdateWidget(AppCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      previousValue = oldWidget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Semantics(
      label: widget.semanticLabel,
      checked: widget.value,
      child: GestureDetector(
        onTap: () => widget.onChanged?.call(!widget.value),
        child: AnimatedContainer(
          duration: kRadialReactionDuration,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.value ? cs.primary : Colors.transparent,
            border: Border.all(
              color: widget.value ? cs.primary : cs.outline,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.value
              ? Icon(Icons.check, size: 18, color: cs.onPrimary)
              : null,
        ),
      ),
    );
  }
}
