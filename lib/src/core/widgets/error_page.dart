import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

class AppErrorPage extends StatefulWidget {
  const new({required this.details, super.key});

  final FlutterErrorDetails details;

  @override
  State<AppErrorPage> createState() => _AppErrorPageState();
}

class _AppErrorPageState extends State<AppErrorPage> {
  Timer? timer;
  bool copied = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: .ltr,
      child: Material(
        type: .transparency,
        child: Semantics(
          container: true,
          label: 'Something went wrong. Restarting the app should fix it.',
          child: ExcludeSemantics(
            child: GestureDetector(
              behavior: .opaque,
              onLongPress: copy,
              child: LayoutBuilder(
                builder: (context, c) {
                  final full =
                      c.maxHeight.isFinite &&
                      c.maxHeight >= 320 &&
                      c.maxWidth.isFinite &&
                      c.maxWidth >= 300;

                  // Only fill bounded axes; under unbounded constraints (lists,
                  // FittedBox) the view sizes to its content.
                  return Container(
                    width: c.hasBoundedWidth ? c.maxWidth : null,
                    height: c.hasBoundedHeight ? c.maxHeight : null,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: .circular(full ? 0 : 28),
                    ),
                    child: full
                        ? _FullView(details: widget.details, copied: copied)
                        : _CompactView(details: widget.details, copied: copied),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> copy() async {
    unawaited(HapticFeedback.mediumImpact());
    await Clipboard.setData(
      ClipboardData(
        text:
            '${widget.details.exceptionAsString()}\n\n${widget.details.stack}',
      ),
    );
    if (!mounted) return;
    setState(() => copied = true);
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      setState(() => copied = false);
    });
  }
}

class _FullView extends StatelessWidget {
  const new({required this.details, required this.copied});

  final FlutterErrorDetails details;
  final bool copied;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final padding = MediaQuery.maybePaddingOf(context);

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: .fromLTRB(
              32,
              (padding?.top ?? 0) + 32,
              32,
              (padding?.bottom ?? 0) + 32,
            ),
            child: Column(
              spacing: 32,
              mainAxisAlignment: .center,
              children: [
                Column(
                  mainAxisSize: .min,
                  children: [
                    _Badge(size: 104, copied: copied),
                    const SizedBox(height: 24),
                    Text(
                      'Something went wrong',
                      textAlign: .center,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: .w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Restarting the app should fix it.',
                      textAlign: .center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer.withValues(
                          alpha: .75,
                        ),
                      ),
                    ),
                  ],
                ),
                if (kDebugMode)
                  _DebugText(
                    '${details.exceptionAsString()}\n\n${details.stack}',
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactView extends StatelessWidget {
  const new({required this.details, required this.copied});

  final FlutterErrorDetails details;
  final bool copied;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(12),
        child: FittedBox(
          fit: .scaleDown,
          child: Column(
            spacing: 8,
            mainAxisSize: .min,
            children: [
              _Badge(size: 48, copied: copied),
              if (kDebugMode)
                SizedBox(
                  width: 240,
                  child: _DebugText(
                    details.exceptionAsString(),
                    maxLines: 2,
                    textAlign: .center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const new({required this.size, required this.copied});

  final double size;
  final bool copied;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: colorScheme.primary,
        shape: const StarBorder(
          points: 12,
          innerRadiusRatio: .8,
          pointRounding: .7,
          valleyRounding: .3,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          copied ? Icons.check_rounded : Icons.priority_high_rounded,
          key: ValueKey(copied),
          color: colorScheme.onPrimary,
          size: size * .4,
        ),
      ),
    );
  }
}

class _DebugText extends StatelessWidget {
  const new(this.text, {this.maxLines, this.textAlign});

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: maxLines == null ? .fade : .ellipsis,
      style: TextStyle(
        fontFamily: 'monospace',
        fontFamilyFallback: const ['Menlo', 'Courier'],
        fontSize: 12,
        color: colorScheme.onPrimaryContainer.withValues(alpha: .6),
      ),
    );
  }
}
