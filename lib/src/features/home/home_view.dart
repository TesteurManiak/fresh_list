import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/consts.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/widgets/add_grocery_bottom_sheet.dart';

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
          final name = await const AddGroceryBottomSheet().show(context);
          if (name != null) {
            ref.read(groceryListControllerProvider.notifier).create(name: name);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: groceriesValue.when(
        data: (data) {
          return ReorderableListView.builder(
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
        error: (_, __) => Center(child: Text(strings.generic_error)),
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
    return Dismissible(
      key: ObjectKey(grocery),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(groceryListControllerProvider.notifier).delete(grocery);
      },
      child: ListTile(
        title: Text(grocery.name),
        subtitle: Text(grocery.createdAt.toString()),
        trailing: quantity != null ? Text('$quantity') : null,
      ),
    );
  }
}
