import 'package:material_ui/material_ui.dart';
import 'package:motor/motor.dart';

class ExpressiveSearchField extends StatefulWidget {
  const new({
    this.autofocus = false,
    this.focusNode,
    this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.avatar,
    this.controller,
    this.textCapitalization = .none,
    this.onSubmitted,
    super.key,
  });

  final bool autofocus;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? avatar;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onSubmitted;

  @override
  State<ExpressiveSearchField> createState() => _ExpressiveSearchFieldState();
}

class _ExpressiveSearchFieldState extends State<ExpressiveSearchField> {
  late final _controller = widget.controller ?? TextEditingController();
  late final _focusNode = widget.focusNode ?? FocusNode();

  late final ValueNotifier<bool> _showClearButtonNotifier;

  void showClearButtonListener() {
    final currentText = _controller.text;
    final hasFocus = _focusNode.hasFocus;
    _showClearButtonNotifier.value = currentText.isNotEmpty && hasFocus;
  }

  @override
  void initState() {
    super.initState();

    final showClearButton =
        _controller.text.isNotEmpty && (_focusNode.hasFocus);
    _showClearButtonNotifier = ValueNotifier(showClearButton);

    _controller.addListener(showClearButtonListener);
    _focusNode.addListener(showClearButtonListener);
  }

  @override
  void dispose() {
    _controller.removeListener(showClearButtonListener);
    _focusNode.removeListener(showClearButtonListener);

    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _showClearButtonNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return TextField(
      autofocus: widget.autofocus,
      focusNode: _focusNode,
      controller: _controller,
      textCapitalization: widget.textCapitalization,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: cs.surfaceContainerHigh,
        hintText: widget.hintText,
        hintStyle: textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
        constraints: const BoxConstraints(minHeight: 56),
        contentPadding: .all(16),
        border: OutlineInputBorder(
          borderRadius: .circular(28),
          borderSide: BorderSide.none,
        ),
        prefixIcon: switch (widget.leadingIcon) {
          final icon? => Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 4),
            child: icon,
          ),
          null => null,
        },
        suffixIcon: ValueListenableBuilder(
          valueListenable: _showClearButtonNotifier,
          builder: (context, showClearButton, _) {
            return _TrailingItems(
              showClearButton: showClearButton,
              trailingIcon: widget.trailingIcon,
              avatar: widget.avatar,
              onClear: () => _controller.clear(),
            );
          },
        ),
      ),
    );
  }
}

class _TrailingItems extends StatelessWidget {
  const _TrailingItems({
    required this.showClearButton,
    required this.trailingIcon,
    required this.avatar,
    required this.onClear,
  });

  final bool showClearButton;
  final Widget? trailingIcon;
  final Widget? avatar;
  final VoidCallback onClear;

  static const clearButtonKey = ValueKey('clear_btn');
  static const emptyActionKey = ValueKey('empty_action');

  @override
  Widget build(BuildContext context) {
    const spatialMotion = MaterialSpringMotion.expressiveSpatialFast();
    const effectsMotion = MaterialSpringMotion.expressiveEffectsFast();

    final cs = ColorScheme.of(context);

    final activeAction = switch ((showClearButton, trailingIcon)) {
      (true, _) => _ClearButton(key: clearButtonKey, onClear: onClear),
      (false, final icon?) => KeyedSubtree(
        key: icon.key ?? ObjectKey(icon),
        child: icon,
      ),
      (false, null) => const SizedBox.shrink(key: emptyActionKey),
    };

    return Row(
      mainAxisSize: .min,
      children: [
        IconTheme.merge(
          data: IconThemeData(color: cs.onSurfaceVariant, size: 24),
          child: AnimatedSwitcher(
            // Match the settling window of expressiveSpatialFast (~300ms)
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              if (child.key == emptyActionKey) return child;

              return AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  final isEntering =
                      animation.status == .forward ||
                      animation.status == .completed;

                  return _SpringActionTransition(
                    isEntering: isEntering,
                    spatialMotion: spatialMotion,
                    effectsMotion: effectsMotion,
                    rotateOnEnter: child.key == clearButtonKey,
                    collapseWidth: trailingIcon == null,
                    child: child,
                  );
                },
              );
            },
            child: activeAction,
          ),
        ),
        ?avatar,
      ],
    );
  }
}

class _SpringActionTransition extends StatelessWidget {
  const _SpringActionTransition({
    required this.isEntering,
    required this.spatialMotion,
    required this.effectsMotion,
    required this.rotateOnEnter,
    required this.collapseWidth,
    required this.child,
  });

  final bool isEntering;
  final Motion spatialMotion;
  final Motion effectsMotion;
  final bool rotateOnEnter;
  final bool collapseWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final target = isEntering ? 1.0 : 0.0;
    final initial = isEntering ? 0.0 : 1.0;

    return IgnorePointer(
      ignoring: !isEntering,
      child: SingleMotionBuilder(
        motion: effectsMotion,
        value: target,
        builder: (_, opacity, child) =>
            Opacity(opacity: opacity.clamp(0.0, 1.0), child: child),
        child: SingleMotionBuilder(
          motion: spatialMotion,
          from: initial,
          value: target,
          builder: (context, spatial, child) {
            final scale = 0.65 + (0.35 * spatial);
            final angle = rotateOnEnter ? -0.314 * (1.0 - spatial) : 0.0;

            final transformed = Transform.scale(
              scale: scale.clamp(0.0, 1.5),
              child: Transform.rotate(angle: angle, child: child),
            );

            if (!collapseWidth) return transformed;

            return Align(
              alignment: Alignment.center,
              widthFactor: spatial.clamp(0.0, 1.0),
              child: transformed,
            );
          },
          child: child,
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.onClear, super.key});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);
    return IconButton(
      icon: Icon(Icons.clear),
      tooltip: materialLocalizations.clearButtonTooltip,
      onPressed: onClear,
    );
  }
}
