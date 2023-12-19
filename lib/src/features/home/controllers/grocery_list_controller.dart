import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/data/repositories/home_repository.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

part 'grocery_list_controller.g.dart';

@riverpod
Stream<List<Grocery>> watchGroceries(WatchGroceriesRef ref) {
  return ref.watch(homeLocalDatasourceProvider).watchGroceries();
}

@riverpod
class GroceryListController extends _$GroceryListController {
  @override
  Future<List<Grocery>> build() async {
    final initialGroceries = await ref.read(watchGroceriesProvider.future);

    ref.listen(watchGroceriesProvider, (_, next) {
      next.whenData((data) => state = AsyncData(data));
    });

    return initialGroceries;
  }

  void createGrocery(Grocery grocery) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    final newElement = grocery.copyWith(order: elements.length);
    state = AsyncData([...elements, newElement]);
    ref.read(homeRepositoryProvider).addGrocery(newElement);
  }

  void updateGrocery(Grocery grocery) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    ref.read(homeRepositoryProvider).updateGrocery(grocery);
  }

  void deleteGrocery(Grocery grocery) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    final newList = List.of(elements)..remove(grocery);

    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(order: i);
    }

    state = AsyncData(newList);
    ref.read(homeLocalDatasourceProvider).replaceGroceries(newList);
  }

  void reorder(int oldIndex, int newIndex) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    int nextIndex = newIndex;

    final newList = List.of(elements);
    final elemToMove = newList.removeAt(oldIndex);
    if (nextIndex > oldIndex) nextIndex--;
    nextIndex = nextIndex.clamp(0, newList.length);

    newList.insert(nextIndex, elemToMove);

    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(order: i);
    }

    state = AsyncData(newList);
    ref.read(homeRepositoryProvider).updateGroceries(newList);
  }

  Future<void> shareList() async {
    final groceries = state.valueOrNull;
    if (groceries == null || groceries.isEmpty) return;

    final shareBuffer = StringBuffer();
    for (final grocery in groceries) {
      shareBuffer.writeln('- ${grocery.name}');
    }
    await Share.share(shareBuffer.toString());
  }

  void toggle(Grocery grocery) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    final newList = List.of(elements);
    final index = newList.indexOf(grocery);
    final newValue = grocery.copyWith(completed: !grocery.completed);
    newList[index] = newValue;

    state = AsyncData(newList);
    ref.read(homeRepositoryProvider).updateGrocery(newValue);
  }
}
