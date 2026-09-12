import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

class GroceryTile extends ConsumerWidget {
  const new(this.grocery, {required Key super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key('GroceryTile-${grocery.id}'),
      dismissThresholds: const {DismissDirection.startToEnd: 0.2},
      movementDuration: const Duration(milliseconds: 300),
      confirmDismiss: (direction) async {
        if (direction == .endToStart) return true;
        return false;
      },
      onDismissed: (direction) {
        if (direction == .endToStart) {
          unawaited(
            ref
                .read(groceryListControllerProvider.notifier)
                .deleteGrocery(grocery),
          );
        }
      },
      child: Container(
        margin: const .symmetric(vertical: 4),
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          borderRadius: .circular(10),
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => showEditionBottomSheet(context, ref, grocery),
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
    );
  }

  Future<void> showEditionBottomSheet(
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
