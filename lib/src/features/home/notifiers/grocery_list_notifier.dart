import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/clock.dart';
import 'package:fresh_list/src/core/models/grocery.dart';
import 'package:fresh_list/src/core/models/recent_search.dart';
import 'package:fresh_list/src/core/sharing/shared_grocery_list_codec.dart';
import 'package:fresh_list/src/features/home/data/repositories/home_repository.dart';
import 'package:fresh_list/src/features/home/data/sources/home_local_datasource.dart';

final groceryListNotifierProvider =
    StreamNotifierProvider.autoDispose<GroceryListNotifier, IList<Grocery>>(
      GroceryListNotifier.new,
    );

class GroceryListNotifier extends StreamNotifier<IList<Grocery>> {
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

  /// Appends [items] not already in the list (by name, case-insensitive) and
  /// returns how many were added.
  Future<int> importGroceries(IList<SharedGrocery> items) async {
    final elements = state.value;
    if (elements == null) return 0;

    final names = {for (final g in elements) g.name.toLowerCase()};
    final now = ref.read(appClockProvider).now();
    var added = 0;
    for (final (index, item) in items.indexed) {
      // `add` also dedupes repeated names within the received list.
      if (!names.add(item.name.toLowerCase())) continue;

      await createGrocery(
        Grocery(
          id: const GroceryId(0),
          order: elements.length + index,
          name: item.name,
          completed: item.completed,
          updatedAt: now,
        ),
      );
      added++;
    }
    return added;
  }

  Future<void> updateGrocery(Grocery grocery) async {
    final elements = state.value;
    if (elements == null) return;

    final updated = elements
        .map((e) => e.id == grocery.id ? grocery : e)
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

  Future<void> clearGroceries() async {
    state = const AsyncData(IListConst([]));
    await ref.read(homeLocalDatasourceProvider).clearGroceries();
  }
}

final watchRecentSearchesProvider = StreamProvider.autoDispose
    .family<IList<RecentSearch>, String>((ref, query) {
      if (query.isEmpty) return Stream.value(const IListConst([]));
      return ref.watch(homeLocalDatasourceProvider).watchRecentSearches(query);
    });
