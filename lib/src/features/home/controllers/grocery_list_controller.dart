import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/data/repositories/home_repository.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

final groceryListControllerProvider =
    StreamNotifierProvider.autoDispose<GroceryListController, IList<Grocery>>(
      GroceryListController.new,
    );

class GroceryListController extends StreamNotifier<IList<Grocery>> {
  @override
  Stream<IList<Grocery>> build() =>
      ref.watch(homeLocalDatasourceProvider).watchGroceries();

  Future<void> createGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    final newElement = grocery.copyWith(order: elements.length);
    state = AsyncData(elements.add(newElement));
    await ref.read(homeRepositoryProvider).addGrocery(newElement);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    final updated = elements
        .map((g) => g.id == grocery.id ? grocery : g)
        .toIList();
    state = AsyncData(updated);
    await ref.read(homeRepositoryProvider).updateGrocery(grocery);
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    state = AsyncData(elements.removeWhere((g) => g.id == grocery.id));

    await ref
        .read(homeLocalDatasourceProvider)
        .deleteGrocery(id: grocery.id, order: grocery.order);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final elements = state.value;
    if (elements == null ||
        oldIndex == newIndex ||
        oldIndex < 0 ||
        oldIndex >= elements.length ||
        newIndex < 0 ||
        newIndex >= elements.length) {
      return;
    }

    final elementToMove = elements[oldIndex];
    final list = elements.unlock;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    final reordered = list.indexed
        .map((entry) => entry.$2.copyWith(order: entry.$1))
        .toIList();
    state = AsyncData(reordered);

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
    final elements = state.value;
    if (elements != null) {
      final updated = elements
          .map(
            (g) => g.id == grocery.id ? g.copyWith(completed: !g.completed) : g,
          )
          .toIList();
      state = AsyncData(updated);
    }

    await ref
        .read(homeLocalDatasourceProvider)
        .setGroceryCompleted(grocery.id, completed: !grocery.completed);
  }
}
