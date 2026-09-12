import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/data/repositories/home_repository.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

final _watchGroceriesProvider = StreamProvider.autoDispose<IList<Grocery>>(
  (ref) => ref.watch(homeLocalDatasourceProvider).watchGroceries(),
);

final groceryListControllerProvider =
    AsyncNotifierProvider.autoDispose<GroceryListController, IList<Grocery>>(
      GroceryListController.new,
    );

class GroceryListController extends AsyncNotifier<IList<Grocery>> {
  @override
  Future<IList<Grocery>> build() => ref.watch(_watchGroceriesProvider.future);

  Future<void> createGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    final newElement = grocery.copyWith(order: elements.length);
    await ref.read(homeRepositoryProvider).addGrocery(newElement);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    await ref.read(homeRepositoryProvider).updateGrocery(grocery);
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    await ref
        .read(homeLocalDatasourceProvider)
        .deleteGrocery(id: grocery.id, order: grocery.order);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final elements = state.value;
    if (elements == null) return;

    final elementToMove = elements[oldIndex];
    await ref
        .read(homeLocalDatasourceProvider)
        .reorderGroceries(
          id: elementToMove.id,
          oldIndex: oldIndex,
          newIndex: newIndex,
        );
  }

  Future<void> shareList() async {
    final groceries = state.value;
    if (groceries == null || groceries.isEmpty) return;

    final shareBuffer = StringBuffer();
    for (final grocery in groceries) {
      shareBuffer.writeln('- ${grocery.name}');
    }
    await SharePlus.instance.share(ShareParams(text: shareBuffer.toString()));
  }

  Future<void> toggle(Grocery grocery) async {
    await ref
        .read(homeLocalDatasourceProvider)
        .setGroceryCompleted(grocery.id, completed: !grocery.completed);
  }
}
