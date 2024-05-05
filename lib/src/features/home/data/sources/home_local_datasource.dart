import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/core/database/database.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';

part 'home_local_datasource.g.dart';

@riverpod
HomeLocalDataSource homeLocalDatasource(HomeLocalDatasourceRef ref) {
  return HomeLocalDataSource(ref);
}

class HomeLocalDataSource {
  const HomeLocalDataSource(this.ref);

  final HomeLocalDatasourceRef ref;

  Stream<List<Grocery>> watchGroceries() {
    final db = ref.read(appDatabaseProvider);
    return (db.select(db.dbGroceries)
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .watch()
        .map((groceries) => groceries.map((e) => e.toModel()).toList());
  }

  Stream<List<RecentSearch>> watchRecentSearches(String value) {
    final db = ref.read(appDatabaseProvider);
    return (db.select(db.dbRecentSearches)
          ..where((a) => a.query.like('$value%'))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ])
          ..limit(4))
        .watch()
        .map((searches) => searches.map((e) => e.toModel()).toList());
  }

  Future<void> updateGrocery(Grocery grocery) async {
    final db = ref.read(appDatabaseProvider);
    await db.into(db.dbGroceries).insertOnConflictUpdate(grocery.toEntity());
  }

  Future<void> reorderGroceries(List<Grocery> groceries) async {
    final db = ref.read(appDatabaseProvider);
    await db.batch((b) {
      b.replaceAll(
        db.dbGroceries,
        groceries.map((e) => e.toEntity()),
      );
    });
  }

  Future<int> addGrocery(Grocery grocery) {
    final db = ref.read(appDatabaseProvider);
    return db.into(db.dbGroceries).insert(grocery.toCompanion());
  }

  Future<void> deleteGrocery(Grocery grocery, List<Grocery> newOrder) async {
    final db = ref.read(appDatabaseProvider);
    await db.batch((b) {
      b
        ..delete(db.dbGroceries, grocery.toEntity())
        ..replaceAll(db.dbGroceries, newOrder.map((e) => e.toEntity()));
    });
  }

  Future<void> addRecentSearch(String query) async {
    final db = ref.read(appDatabaseProvider);
    final clock = ref.read(appClockProvider);
    await db.into(db.dbRecentSearches).insertOnConflictUpdate(
          DbRecentSearchesCompanion.insert(
            query: query,
            timestamp: clock.now(),
          ),
        );
  }

  Future<List<RecentSearch>> getRecentSearches(String value) async {
    final db = ref.read(appDatabaseProvider);
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
