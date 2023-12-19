import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

class GroceryTile extends ConsumerWidget {
  const GroceryTile(
    this.grocery, {
    required Key super.key,
  });

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = grocery.quantity;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key('Dismissible-${grocery.order}'),
      dismissThresholds: const {DismissDirection.startToEnd: 0.2},
      movementDuration: const Duration(milliseconds: 300),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return Future.value(true);
        } else if (direction == DismissDirection.startToEnd) {
          ref.read(groceryListControllerProvider.notifier).toggle(grocery);
        }
        return Future.value(false);
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          ref
              .read(groceryListControllerProvider.notifier)
              .deleteGrocery(grocery);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withOpacity(0.1),
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
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Checkbox(
                    value: grocery.completed,
                    onChanged: (_) {
                      ref
                          .read(groceryListControllerProvider.notifier)
                          .toggle(grocery);
                    },
                  ),
                  Expanded(child: Text(grocery.name)),
                  if (quantity != null)
                    Flexible(child: Text('$quantity', maxLines: 1)),
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
    final grocery =
        await EditGroceryBottomSheet(initialValue: initialValue).show(context);
    if (grocery == null || grocery == this.grocery) return;

    ref.read(groceryListControllerProvider.notifier).updateGrocery(grocery);
  }
}
