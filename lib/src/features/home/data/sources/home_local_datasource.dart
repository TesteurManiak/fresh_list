import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

  Future<void> updateGroceries(List<Grocery> groceries) async {
    final db = ref.read(appDatabaseProvider);
    await db.batch((b) {
      b.insertAllOnConflictUpdate(
        db.dbGroceries,
        groceries.map((e) => e.toEntity()),
      );
    });
  }

  Future<void> addGrocery(Grocery grocery) async {
    // final isar = await ref.read(isarDbProvider.future);
    // await isar.writeTxn(() async {
    //   await isar.groceries.putByOrder(grocery);
    // });
  }

  Future<void> replaceGroceries(List<Grocery> groceries) async {
    // final isar = await ref.read(isarDbProvider.future);
    // await isar.writeTxn(() async {
    //   await isar.groceries.clear();
    //   await isar.groceries.putAllByOrder(groceries);
    // });
  }
}

extension on Grocery {
  DbGrocery toEntity() {
    return DbGrocery(
      order: order,
      name: name,
      completed: completed,
      quantity: quantity,
    );
  }
}
