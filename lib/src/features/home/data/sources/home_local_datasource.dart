import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/core/database/database.dart';
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
    return (db.select(db.dbGroceries)
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .watch()
        .map((groceries) => groceries.map((e) => e.toModel()).toIList());
  }

  Stream<IList<RecentSearch>> watchRecentSearches(String value) {
    return (db.select(db.dbRecentSearches)
          ..where((a) => a.query.like('$value%'))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ])
          ..limit(kMaxRecentSearches))
        .watch()
        .map((searches) => searches.map((e) => e.toModel()).toIList());
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await db.into(db.dbGroceries).insertOnConflictUpdate(grocery.toEntity());
  }

  Future<void> setGroceryCompleted(int id, {required bool completed}) async {
    await (db.update(db.dbGroceries)..where((g) => g.id.equals(id))).write(
      DbGroceriesCompanion(completed: Value(completed)),
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
        await (db.update(db.dbGroceries)..where(
              (g) =>
                  g.order.isBiggerThanValue(oldIndex) &
                  g.order.isSmallerThanValue(newIndex),
            ))
            .write(
              DbGroceriesCompanion.custom(
                order: db.dbGroceries.order - const Constant(1),
              ),
            );
      } else {
        // Moving up: shift intermediate items DOWN (position + 1)
        await (db.update(db.dbGroceries)..where(
              (g) =>
                  g.order.isBiggerThanValue(newIndex) &
                  g.order.isSmallerThanValue(oldIndex),
            ))
            .write(
              DbGroceriesCompanion.custom(
                order: db.dbGroceries.order + const Constant(1),
              ),
            );
      }

      // Set the target item to its final position
      await (db.update(db.dbGroceries)..where((g) => g.id.equals(id))).write(
        DbGroceriesCompanion.custom(order: Constant(newIndex)),
      );
    });
  }

  Future<int> addGrocery(Grocery grocery) {
    return db.into(db.dbGroceries).insert(grocery.insert());
  }

  Future<void> deleteGrocery({required int id, required int order}) async {
    await db.transaction(() async {
      // Delete the specified entry
      await (db.delete(db.dbGroceries)..where((g) => g.id.equals(id))).go();

      // Shift all subsequent items down by 1 to fill the gap
      await (db.update(
        db.dbGroceries,
      )..where((g) => g.order.isBiggerThanValue(order))).write(
        DbGroceriesCompanion.custom(
          order: db.dbGroceries.order - const Constant(1),
        ),
      );
    });
  }

  Future<void> addRecentSearch(String query) async {
    await db
        .into(db.dbRecentSearches)
        .insertOnConflictUpdate(
          DbRecentSearchesCompanion.insert(
            query: query,
            timestamp: clock.now(),
          ),
        );
  }

  Future<List<RecentSearch>> getRecentSearches(String value) async {
    return (db.select(db.dbRecentSearches)
          ..where((a) => a.query.like('$value%'))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ])
          ..limit(kMaxRecentSearches))
        .get()
        .then((searches) => searches.map((e) => e.toModel()).toList());
  }
}

extension on Grocery {
  DbGroceriesCompanion insert() {
    return DbGroceriesCompanion.insert(
      order: order,
      name: name,
      completed: completed,
      quantity: Value.absentIfNull(quantity),
    );
  }

  DbGrocery toEntity() {
    return DbGrocery(
      id: id,
      order: order,
      name: name,
      completed: completed,
      quantity: quantity,
    );
  }
}
