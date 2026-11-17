import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:todo_list/src/core/utils/haptics_helper.dart';
import 'package:todo_list/src/core/widgets/checkbox.dart';
import 'package:todo_list/src/core/widgets/dismissible.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

const _kAnimationDuration = Duration(milliseconds: 300);
const _kAnimationCurve = Curves.easeOutBack;

// Expressive shape morph: active tiles are fully rounded, completed ones
// settle into a tighter shape.
const _kActiveRadius = BorderRadius.all(.circular(28));
const _kCompletedRadius = BorderRadius.all(.circular(16));

class GroceryTile extends ConsumerStatefulWidget {
  const new(
    this.grocery, {
    required Key super.key,
    this.showSwipeHint = false,
    this.dismissThreshold = 0.4,
  });

  final Grocery grocery;
  final double dismissThreshold;

  /// Whether this tile should briefly reveal its swipe action the first time
  /// the user ever sees the list.
  final bool showSwipeHint;

  @override
  ConsumerState<GroceryTile> createState() => _GroceryTileState();
}

class _GroceryTileState extends ConsumerState<GroceryTile> {
  final controller = AppDismissibleController();

  double dragProgress = 0;
  bool hasTriggeredHaptic = false;

  @override
  void initState() {
    super.initState();
    if (widget.showSwipeHint) runSwipeHint();
  }

  Future<void> runSwipeHint() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final key = SharedPrefsKey.swipeHintShown.key;
    if (prefs.getBool(key) ?? false) return;
    await prefs.setBool(key, true);

    // Let the page finish settling first.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    await controller.peek();
  }

  @override
  Widget build(BuildContext context) {
    final grocery = widget.grocery;
    final isThresholdReached = dragProgress >= widget.dismissThreshold;

    return Padding(
      padding: const .symmetric(vertical: 3),
      child: AppDismissible(
        key: Key('GroceryTile-${grocery.id}'),
        controller: controller,
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
          borderRadius: _kActiveRadius,
          isThresholdReached: isThresholdReached,
          dragProgress: dragProgress,
        ),
        child: _GroceryCard(grocery: grocery),
      ),
    );
  }
}

class _GroceryCard extends ConsumerWidget {
  const new({required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final completed = grocery.completed;
    final borderRadius = completed ? _kCompletedRadius : _kActiveRadius;

    return AnimatedContainer(
      duration: _kAnimationDuration,
      curve: _kAnimationCurve,
      clipBehavior: .antiAlias,
      constraints: const BoxConstraints(minHeight: 72),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: completed
            ? colorScheme.surfaceContainerLow
            : colorScheme.surfaceContainerHigh,
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
            padding: const .symmetric(horizontal: 20, vertical: 12),
            child: Row(
              spacing: 16,
              children: [
                AppCheckbox(
                  value: completed,
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
                  child: AnimatedDefaultTextStyle(
                    duration: _kAnimationDuration,
                    style: textTheme.titleMedium!.copyWith(
                      decoration: completed ? .lineThrough : null,
                      color: completed
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurface,
                    ),
                    child: Text(grocery.name),
                  ),
                ),
                AnimatedScale(
                  duration: _kAnimationDuration,
                  curve: _kAnimationCurve,
                  scale: completed ? 1.0 : 0.0,
                  child: Icon(
                    Icons.done_all,
                    color: colorScheme.primary,
                    size: 20,
                  ),
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
  const new({
    required this.borderRadius,
    required this.isThresholdReached,
    required this.dragProgress,
  });

  final BorderRadius borderRadius;
  final bool isThresholdReached;
  final double dragProgress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      alignment: .centerRight,
      padding: const .symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: colorScheme.surface,
      ),
      child: FractionallySizedBox(
        widthFactor: dragProgress.clamp(0.0, 1.0),
        heightFactor: 1,
        alignment: .centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: .circular(100),
            ),
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: isThresholdReached ? 1.2 : .9),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutBack,
                builder: (_, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Icon(
                  Icons.delete_outline,
                  color: colorScheme.onError,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
