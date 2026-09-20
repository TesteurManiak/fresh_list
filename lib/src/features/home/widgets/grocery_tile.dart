import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/widgets/checkbox.dart';
import 'package:todo_list/src/core/widgets/dismissible.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

const _kAnimationDuration = Duration(milliseconds: 200);

class GroceryTile extends ConsumerWidget {
  const new(this.grocery, {required Key super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = BorderRadius.all(.circular(16));

    final colorScheme = ColorScheme.of(context);

    return AnimatedContainer(
      duration: _kAnimationDuration,
      margin: const .symmetric(vertical: 4),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          if (!grocery.completed)
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: AppDismissible(
        key: Key('GroceryTile-${grocery.id}'),
        direction: .endToStart,
        onDismissed: (direction) {
          if (direction == .endToStart) {
            unawaited(
              ref
                  .read(groceryListControllerProvider.notifier)
                  .deleteGrocery(grocery),
            );
          }
        },
        background: const _Background(borderRadius: borderRadius),
        child: _GroceryCard(borderRadius: borderRadius, grocery: grocery),
      ),
    );
  }
}

class _GroceryCard extends ConsumerWidget {
  const new({required this.borderRadius, required this.grocery});

  final BorderRadius borderRadius;
  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tileBorderRadius = BorderRadius.all(.circular(12));
    final listTileTheme = ListTileTheme.of(context);

    return AnimatedContainer(
      duration: _kAnimationDuration,
      clipBehavior: .antiAlias,
      constraints: const BoxConstraints(minHeight: 70),
      decoration: BoxDecoration(
        borderRadius: tileBorderRadius,
        color: grocery.completed
            ? listTileTheme.tileColor
            : listTileTheme.selectedTileColor,
      ),
      child: Material(
        type: .transparency,
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: () => _showEditionBottomSheet(context, ref, grocery),
          borderRadius: borderRadius,
          child: Padding(
            padding: listTileTheme.contentPadding ?? .zero,
            child: Row(
              spacing: 16,
              children: [
                AppCheckbox(
                  value: grocery.completed,
                  onChanged: (_) => ref
                      .read(groceryListControllerProvider.notifier)
                      .toggle(grocery),
                ),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: _kAnimationDuration,
                    style: (listTileTheme.titleTextStyle ?? const TextStyle())
                        .copyWith(
                          decoration: grocery.completed ? .lineThrough : null,
                          color: grocery.completed
                              ? const Color(0xFF57423B)
                              : null,
                        ),

                    child: Text(grocery.name),
                  ),
                ),
                AnimatedOpacity(
                  duration: _kAnimationDuration,
                  opacity: grocery.completed ? 1.0 : 0.0,
                  child: const Icon(
                    Icons.done_all,
                    color: Color(0xFF8A726A),
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
    const onBackgroundColor = Color(0xFFFFFBFF);

    final strings = AppLocalizations.of(context);

    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: const Color(0xFFBF542C),
      ),
      padding: const .symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .end,
        children: [
          const Icon(Icons.delete, color: onBackgroundColor),
          Text(
            strings.quick_action_delete,
            style: const TextStyle(
              color: onBackgroundColor,
              fontWeight: .w600,
              fontSize: 14,
              height: 18 / 14,
              letterSpacing: 0.35,
            ),
          ),
        ],
      ),
    );
  }
}
