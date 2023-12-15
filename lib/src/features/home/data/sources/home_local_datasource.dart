import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/database/database.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';

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
