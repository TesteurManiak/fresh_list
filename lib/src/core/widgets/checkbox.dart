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
    final colorScheme = ColorScheme.of(context);

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
            color: widget.value
                ? colorScheme.primaryContainer
                : const Color(0xFFF6ECEA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.value
              ? const Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
