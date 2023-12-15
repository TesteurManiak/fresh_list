import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
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

  void create({required String name, double? quantity}) {
    final elements = state.valueOrNull;
    if (elements == null) return;

    final clock = ref.read(appClockProvider);

    final grocery = Grocery(
      order: elements.length,
      name: name,
      createdAt: clock.now(),
    );

    final newList = List.of(elements)..add(grocery);

    state = AsyncData(newList);
    ref.read(homeLocalDatasourceProvider).addGrocery(grocery);
  }

  Future<void> delete(Grocery grocery) async {
    final elements = state.valueOrNull;
    if (elements == null) return;

    final newList = List.of(elements)..remove(grocery);

    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(order: i);
    }

    state = AsyncData(newList);
    await ref.read(homeLocalDatasourceProvider).replaceGroceries(newList);
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
    ref.read(homeLocalDatasourceProvider).updateGroceries(newList);
  }
}
