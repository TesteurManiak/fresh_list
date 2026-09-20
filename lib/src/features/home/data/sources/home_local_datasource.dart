import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/core/database/database.dart';
import 'package:todo_list/src/core/database/groceries_table.dart';
import 'package:todo_list/src/core/database/groceries_table.drift.dart';
import 'package:todo_list/src/core/database/recent_searches_table.dart';
import 'package:todo_list/src/core/database/recent_searches_table.drift.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';

const kMaxRecentSearches = 4;

final homeLocalDatasourceProvider = Provider<HomeLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final clock = ref.watch(appClockProvider);
  return HomeLocalDataSource(db: db, clock: clock);
});

class const HomeLocalDataSource({
  required final AppDatabase db,
  required final Clock clock,
}) {
  Stream<IList<Grocery>> watchGroceries() {
    return (db.select(db.groceriesTable)
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .watch()
        .map((g) => g.map((e) => e.toEntity()).toIList());
  }

  Stream<IList<RecentSearch>> watchRecentSearches(String value) {
    return (db.select(db.recentSearchesTable)
          ..where((a) => a.query.like('$value%'))
          ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: .desc)])
          ..limit(kMaxRecentSearches))
        .watch()
        .map((searches) => searches.map((e) => e.toEntity()).toIList());
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await db.into(db.groceriesTable).insertOnConflictUpdate(grocery.toModel());
  }

  Future<void> setGroceryCompleted(int id, {required bool completed}) async {
    await (db.update(db.groceriesTable)..where((g) => g.id.equals(id))).write(
      GroceriesTableCompanion(completed: Value(completed)),
    );
  }

  /// Update the `order` column of each grocery in the database.
  Future<void> reorderGroceries({
    required int id,
    required int oldIndex,
    required int newIndex,
  }) async {
    if (oldIndex == newIndex) return;

    await db.transaction(() async {
      if (oldIndex < newIndex) {
        // Moving down: shift intermediate items UP (position - 1)
        await (db.update(db.groceriesTable)..where(
              (g) =>
                  g.order.isBiggerThanValue(oldIndex) &
                  g.order.isSmallerThanValue(newIndex),
            ))
            .write(
              GroceriesTableCompanion.custom(
                order: db.groceriesTable.order - const Constant(1),
              ),
            );
      } else {
        // Moving up: shift intermediate items DOWN (position + 1)
        await (db.update(db.groceriesTable)..where(
              (g) =>
                  g.order.isBiggerThanValue(newIndex) &
                  g.order.isSmallerThanValue(oldIndex),
            ))
            .write(
              GroceriesTableCompanion.custom(
                order: db.groceriesTable.order + const Constant(1),
              ),
            );
      }

      // Set the target item to its final position
      await (db.update(db.groceriesTable)..where((g) => g.id.equals(id))).write(
        GroceriesTableCompanion.custom(order: Constant(newIndex)),
      );
    });
  }

  Future<int> addGrocery(Grocery grocery) =>
      db.into(db.groceriesTable).insert(grocery.insert());

  Future<void> deleteGrocery({required int id, required int order}) async {
    await db.transaction(() async {
      // Delete the specified entry
      await (db.delete(db.groceriesTable)..where((g) => g.id.equals(id))).go();

      // Shift all subsequent items down by 1 to fill the gap
      await (db.update(
        db.groceriesTable,
      )..where((g) => g.order.isBiggerThanValue(order))).write(
        GroceriesTableCompanion.custom(
          order: db.groceriesTable.order - const Constant(1),
        ),
      );
    });
  }

  Future<void> addRecentSearch(String query) async {
    await db
        .into(db.recentSearchesTable)
        .insertOnConflictUpdate(
          RecentSearchesTableCompanion.insert(
            query: query,
            timestamp: clock.now(),
          ),
        );
  }
}

extension on Grocery {
  GroceriesTableCompanion insert() {
    return GroceriesTableCompanion.insert(
      order: order,
      name: name,
      completed: completed,
      quantity: Value(quantity),
    );
  }

  GroceriesTableData toModel() {
    return GroceriesTableData(
      id: id,
      order: order,
      name: name,
      completed: completed,
      quantity: quantity,
    );
  }
}
