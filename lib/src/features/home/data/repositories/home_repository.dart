import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/models/grocery.dart';
import 'package:fresh_list/src/features/home/data/sources/home_local_datasource.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final localDatasource = ref.watch(homeLocalDatasourceProvider);
  return HomeRepository(localDataSource: localDatasource);
});

class const HomeRepository({
  required final HomeLocalDataSource localDataSource,
}) {
  Future<void> addGrocery(Grocery grocery) async {
    await localDataSource.addGrocery(grocery);
    await localDataSource.addRecentSearch(grocery.name);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await localDataSource.updateGrocery(grocery);
    await localDataSource.addRecentSearch(grocery.name);
  }
}
