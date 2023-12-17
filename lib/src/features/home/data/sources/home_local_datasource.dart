import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/database/database.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/data/models/recent_search.dart';

part 'home_local_datasource.g.dart';

@riverpod
HomeLocalDataSource homeLocalDatasource(HomeLocalDatasourceRef ref) {
  return HomeLocalDataSource(ref);
}

class HomeLocalDataSource {
  const HomeLocalDataSource(this.ref);

  final HomeLocalDatasourceRef ref;

  Stream<List<Grocery>> watchGroceries() async* {
    final isar = await ref.read(isarDbProvider.future);
    final query = isar.groceries.where().sortByOrder().build();
    yield* query.watch(fireImmediately: true);
  }

  Stream<List<RecentSearch>> watchRecentSearches(String value) async* {
    final isar = await ref.read(isarDbProvider.future);
    final query = isar.recentSearches
        .where()
        .filter()
        .queryStartsWith(value, caseSensitive: false)
        .sortByTimestampDesc()
        .build();
    yield* query.watch(fireImmediately: true).take(4);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    final isar = await ref.read(isarDbProvider.future);
    await isar.writeTxn(() async {
      await isar.groceries.putByOrder(grocery);
    });
  }

  Future<void> updateGroceries(List<Grocery> groceries) async {
    final isar = await ref.read(isarDbProvider.future);
    await isar.writeTxn(() async {
      await isar.groceries.putAllByOrder(groceries);
    });
  }

  Future<void> addGrocery(Grocery grocery) async {
    final isar = await ref.read(isarDbProvider.future);
    await isar.writeTxn(() async {
      await isar.groceries.putByOrder(grocery);
    });
  }

  Future<void> replaceGroceries(List<Grocery> groceries) async {
    final isar = await ref.read(isarDbProvider.future);
    await isar.writeTxn(() async {
      await isar.groceries.clear();
      await isar.groceries.putAllByOrder(groceries);
    });
  }
}
