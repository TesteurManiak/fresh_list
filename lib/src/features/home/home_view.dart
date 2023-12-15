import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/gen/app_localizations.dart';
import 'package:todo_list/src/core/consts.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/widgets/separated_row.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceriesValue = ref.watch(groceryListControllerProvider);
    final strings = context.strings;

    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appName)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final grocery = await const EditGroceryBottomSheet().show(context);
          if (grocery != null) {
            ref
                .read(groceryListControllerProvider.notifier)
                .createGrocery(grocery);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: groceriesValue.when(
        data: (data) {
          if (data.isEmpty) {
            return _CenteredText(strings.empty_grocery_list);
          }

          return ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, i) => _GroceryTile(data[i], key: ValueKey(i)),
            itemCount: data.length,
            onReorder: (oldIndex, newIndex) {
              ref.read(groceryListControllerProvider.notifier).reorder(
                    oldIndex,
                    newIndex,
                  );
            },
          );
        },
        error: (_, __) => _CenteredText(strings.generic_error),
        loading: () => const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

class _GroceryTile extends ConsumerWidget {
  const _GroceryTile(this.grocery, {required Key super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = grocery.quantity;
    final theme = Theme.of(context);
    final strings = context.strings;
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: ObjectKey(grocery),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(groceryListControllerProvider.notifier).deleteGrocery(grocery);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
            onTap: () async {
              final newGrocery =
                  await EditGroceryBottomSheet(initialValue: grocery)
                      .show(context);
              if (newGrocery == null || newGrocery == grocery) return;

              ref
                  .read(groceryListControllerProvider.notifier)
                  .updateGrocery(newGrocery);
            },
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
                      // TODO(Guillaume): handle action
                    },
                    itemBuilder: (context) {
                      return [
                        for (final e in _GroceryTileAction.values)
                          PopupMenuItem<_GroceryTileAction>(
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
}

class _CenteredText extends StatelessWidget {
  const _CenteredText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
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
