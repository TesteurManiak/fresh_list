import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/utils/haptics_helper.dart';
import 'package:todo_list/src/core/widgets/checkbox.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

const _kAnimationDuration = Duration(milliseconds: 300);
const _kAnimationCurve = Curves.easeOutBack;

class GroceryTile extends ConsumerStatefulWidget {
  const new(
    this.grocery, {
    required Key super.key,
    required this.borderRadius,
    this.dismissThreshold = 0.4,
  });

  final Grocery grocery;
  final double dismissThreshold;
  final BorderRadius borderRadius;

  static const outerRadius = 16.0;
  static const innerRadius = 2.0;
  static const tileGap = 2.0;

  static BorderRadius radiusFor(int index, int length, bool selected) {
    const Radius outer = Radius.circular(outerRadius);
    const Radius inner = Radius.circular(innerRadius);

    return .vertical(
      top: (index == 0 || selected) ? outer : inner,
      bottom: (index == length - 1 || selected) ? outer : inner,
    );
  }

  @override
  ConsumerState<GroceryTile> createState() => _GroceryTileState();
}

class _GroceryTileState extends ConsumerState<GroceryTile> {
  double dragProgress = 0;
  bool hasTriggeredHaptic = false;

  @override
  Widget build(BuildContext context) {
    final grocery = widget.grocery;
    final isThresholdReached = dragProgress >= widget.dismissThreshold;

    return Padding(
      padding: const .symmetric(vertical: GroceryTile.tileGap),
      child: Dismissible(
        key: Key('GroceryTile-${grocery.id}'),
        direction: .endToStart,
        dismissThresholds: {.endToStart: widget.dismissThreshold},
        onUpdate: (details) {
          setState(() => dragProgress = details.progress);

          if (details.progress >= widget.dismissThreshold &&
              !hasTriggeredHaptic) {
            HapticFeedback.lightImpact();
            hasTriggeredHaptic = true;
          } else if (details.progress < widget.dismissThreshold &&
              hasTriggeredHaptic) {
            hasTriggeredHaptic = false;
          }
        },
        onDismissed: (_) => ref
            .read(groceryListControllerProvider.notifier)
            .deleteGrocery(grocery),
        background: _Background(
          isThresholdReached: isThresholdReached,
          dragProgress: dragProgress,
        ),
        child: _GroceryCard(
          grocery: grocery,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }
}

class _GroceryCard extends ConsumerWidget {
  const new({required this.grocery, required this.borderRadius});

  final Grocery grocery;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = ColorScheme.of(context);
    final completed = grocery.completed;

    return AnimatedContainer(
      duration: _kAnimationDuration,
      curve: _kAnimationCurve,
      clipBehavior: .antiAlias,
      constraints: const BoxConstraints(minHeight: 56, maxHeight: 88),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: completed ? cs.surfaceContainerLow : cs.surfaceContainer,
      ),
      child: Material(
        type: .transparency,
        child: InkWell(
          onTap: () {
            HapticsHelper.light();
            _showEditionBottomSheet(context, ref, grocery);
          },
          borderRadius: borderRadius,
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 12),
            child: Row(
              spacing: 12,
              children: [
                AppCheckbox(
                  value: completed,
                  size: 24,
                  onChanged: (_) {
                    unawaited(
                      completed
                          ? HapticsHelper.light()
                          : HapticsHelper.success(),
                    );
                    unawaited(
                      ref
                          .read(groceryListControllerProvider.notifier)
                          .toggle(grocery),
                    );
                  },
                ),
                Expanded(
                  child: Text(
                    grocery.name,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: .w400,
                      decoration: completed ? .lineThrough : null,
                      height: 24 / 16,
                      color: completed ? cs.onSurfaceVariant : cs.onSurface,
                    ),
                  ),
                ),
                AnimatedScale(
                  duration: _kAnimationDuration,
                  curve: _kAnimationCurve,
                  scale: completed ? 1.0 : 0.0,
                  child: Icon(Icons.done_all, color: cs.primary, size: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditionBottomSheet(
    BuildContext context,
    WidgetRef ref,
    Grocery initialValue,
  ) async {
    final grocery = await EditGroceryBottomSheet(initialValue: initialValue)
        .show(context);
    if (grocery == null || grocery == this.grocery || !context.mounted) return;

    unawaited(
      ref.read(groceryListControllerProvider.notifier).updateGrocery(grocery),
    );
  }
}

class _Background extends StatelessWidget {
  const new({required this.isThresholdReached, required this.dragProgress});

  final bool isThresholdReached;
  final double dragProgress;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Container(
      alignment: .centerRight,
      padding: const .symmetric(horizontal: 12, vertical: 6),
      color: cs.surface,
      child: FractionallySizedBox(
        widthFactor: dragProgress.clamp(0.0, 1.0),
        heightFactor: 1,
        alignment: .centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: cs.error,
              shape: const StadiumBorder(),
            ),
            child: Center(
              child: Icon(Icons.delete_outline, color: cs.onError, size: 24),
            ),
          ),
        ),
      ),
    );
  }
}
