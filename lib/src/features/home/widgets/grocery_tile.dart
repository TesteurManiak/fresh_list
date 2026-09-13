import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

class GroceryTile extends ConsumerWidget {
  const new(this.grocery, {required Key super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = BorderRadius.all(.circular(16));

    final colorScheme = ColorScheme.of(context);

    return Padding(
      padding: const .symmetric(vertical: 4),
      child: Dismissible(
        key: Key('GroceryTile-${grocery.id}'),
        direction: DismissDirection.endToStart,
        movementDuration: const Duration(milliseconds: 300),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: colorScheme.surface.withValues(
              alpha: grocery.completed ? .8 : 1,
            ),
            boxShadow: [
              if (!grocery.completed)
                BoxShadow(
                  color: colorScheme.onSurface.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
            ],
          ),
          child: Material(
            type: .transparency,
            child: InkWell(
              onTap: () => _showEditionBottomSheet(context, ref, grocery),
              child: Padding(
                padding: const .all(12),
                child: Row(
                  children: [
                    Checkbox(
                      value: grocery.completed,
                      onChanged: (_) => ref
                          .read(groceryListControllerProvider.notifier)
                          .toggle(grocery),
                    ),
                    Expanded(
                      child: Text(
                        grocery.name,
                        style: TextStyle(
                          decoration: grocery.completed ? .lineThrough : null,
                        ),
                      ),
                    ),
                    if (grocery.quantity case final q?)
                      Flexible(child: Text('$q', maxLines: 1)),
                  ],
                ),
              ),
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
            ),
          ),
        ],
      ),
    );
  }
}
