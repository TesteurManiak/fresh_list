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
    final query = isar.groceries.where().sortByIndex().build();
    yield* query.watch(fireImmediately: true);
  }
}
