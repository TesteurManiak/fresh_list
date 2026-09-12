import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/core/database/database.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';

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
          ..limit(4))
        .watch()
        .map((searches) => searches.map((e) => e.toModel()).toIList());
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await db.into(db.dbGroceries).insertOnConflictUpdate(grocery.toEntity());
  }

  Future<void> reorderGroceries(List<Grocery> groceries) async {
    await db.batch((b) {
      b.replaceAll(db.dbGroceries, groceries.map((e) => e.toEntity()));
    });
  }

  Future<int> addGrocery(Grocery grocery) {
    return db.into(db.dbGroceries).insert(grocery.toCompanion());
  }

  Future<void> deleteGrocery(Grocery grocery, List<Grocery> newOrder) async {
    await db.batch((b) {
      b
        ..delete(db.dbGroceries, grocery.toEntity())
        ..replaceAll(db.dbGroceries, newOrder.map((e) => e.toEntity()));
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
          ..limit(4))
        .get()
        .then((searches) => searches.map((e) => e.toModel()).toList());
  }
}

extension on Grocery {
  DbGroceriesCompanion toCompanion() {
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
