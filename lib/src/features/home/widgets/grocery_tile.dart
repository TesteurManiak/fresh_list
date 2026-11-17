import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
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
  const new(this.grocery, {required Key super.key, this.showSwipeHint = false});

  final Grocery grocery;

  /// Whether this tile should briefly reveal its swipe action the first time
  /// the user ever sees the list.
  final bool showSwipeHint;

  @override
  ConsumerState<GroceryTile> createState() => _GroceryTileState();
}

class _GroceryTileState extends ConsumerState<GroceryTile> {
  final controller = AppDismissibleController();

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

    return Padding(
      padding: const .symmetric(vertical: 3),
      child: AppDismissible(
        key: Key('GroceryTile-${grocery.id}'),
        controller: controller,
        direction: .endToStart,
        onUpdate: (details) {
          if (details.reached && !details.previousReached) {
            HapticsHelper.medium();
          }
        },
        onDismissed: (direction) {
          if (direction == .endToStart) {
            HapticsHelper.heavy();
            ref
                .read(groceryListControllerProvider.notifier)
                .deleteGrocery(grocery);
          }
        },
        background: const _Background(borderRadius: _kActiveRadius),
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
  const new({required this.borderRadius});

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: colorScheme.errorContainer,
      ),
      padding: const .symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .end,
        spacing: 8,
        children: [
          Icon(Icons.delete_rounded, color: colorScheme.onErrorContainer),
          Text(
            strings.quick_action_delete,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}
