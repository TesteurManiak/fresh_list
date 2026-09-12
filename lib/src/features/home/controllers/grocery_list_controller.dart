import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/data/repositories/home_repository.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

final watchGroceriesProvider = StreamProvider.autoDispose<List<Grocery>>(
  (ref) => ref.watch(homeLocalDatasourceProvider).watchGroceries(),
);

final groceryListControllerProvider =
    AsyncNotifierProvider.autoDispose<GroceryListController, IList<Grocery>>(
      GroceryListController.new,
    );

class GroceryListController extends AsyncNotifier<IList<Grocery>> {
  @override
  Future<IList<Grocery>> build() async {
    final initialGroceries = await ref.read(watchGroceriesProvider.future);

    ref.listen(watchGroceriesProvider, (_, next) {
      next.whenData((data) => state = AsyncData(data.lock));
    });

    return initialGroceries.lock;
  }

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
    final elements = state.value;
    if (elements == null) return;

    final newList = elements.unlock..remove(grocery);

    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(order: i);
    }

    state = AsyncData(newList.lock);
    await ref.read(homeLocalDatasourceProvider).deleteGrocery(grocery, newList);

    // TODO(Guillaume): add a toast message to cancel deletion.
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final elements = state.value;
    if (elements == null) return;

    int nextIndex = newIndex;

    final newList = elements.unlock;
    final elemToMove = newList.removeAt(oldIndex);
    if (nextIndex > oldIndex) nextIndex--;
    nextIndex = nextIndex.clamp(0, newList.length);

    newList.insert(nextIndex, elemToMove);

    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(order: i);
    }

    state = AsyncData(newList.lock);
    await ref.read(homeRepositoryProvider).reorderGroceries(newList);
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
    if (elements == null) return;

    final newList = elements.unlock;
    final index = newList.indexOf(grocery);
    final newValue = grocery.copyWith(completed: !grocery.completed);
    newList[index] = newValue;

    state = AsyncData(newList.lock);
    await ref.read(homeRepositoryProvider).updateGrocery(newValue);
  }
}
