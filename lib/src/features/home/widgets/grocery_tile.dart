import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/gen/app_localizations.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/widgets/separated_row.dart';
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
    final strings = context.strings;
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: ObjectKey(grocery),
      onDismissed: (_) {
        ref.read(groceryListControllerProvider.notifier).deleteGrocery(grocery);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
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
              padding: const EdgeInsets.only(
                left: 16,
                top: 8,
                bottom: 8,
              ),
              child: SeparatedRow(
                separator: const SizedBox(width: 16),
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(grocery.name),
                        if (quantity != null) Text('$quantity'),
                      ],
                    ),
                  ),
                  // More button
                  PopupMenuButton<_GroceryTileAction>(
                    onSelected: (action) {
                      switch (action) {
                        case _GroceryTileAction.edit:
                          showEditionBottomSheet(context, ref, grocery);
                        case _GroceryTileAction.delete:
                          ref
                              .read(groceryListControllerProvider.notifier)
                              .deleteGrocery(grocery);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        for (final e in _GroceryTileAction.values)
                          PopupMenuItem<_GroceryTileAction>(
                            value: e,
                            child: Text(e.label(strings)),
                          ),
                      ];
                    },
                  ),
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

enum _GroceryTileAction {
  edit(editLabel),
  delete(deleteLabel);

  const _GroceryTileAction(this.label);

  final LocalizedString label;

  static String editLabel(AppLocalizations strings) {
    return strings.quick_action_edit;
  }

  static String deleteLabel(AppLocalizations strings) {
    return strings.quick_action_delete;
  }
}
