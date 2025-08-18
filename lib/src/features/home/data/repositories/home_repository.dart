import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  final localDatasource = ref.watch(homeLocalDatasourceProvider);
  return HomeRepository(localDataSource: localDatasource);
}

class HomeRepository {
  const HomeRepository({required this.localDataSource});

  final HomeLocalDataSource localDataSource;

  Future<void> reorderGroceries(List<Grocery> groceries) async {
    await localDataSource.reorderGroceries(groceries);
  }

  Future<void> addGrocery(Grocery grocery) async {
    await localDataSource.addGrocery(grocery);
    await localDataSource.addRecentSearch(grocery.name);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await localDataSource.updateGrocery(grocery);
    await localDataSource.addRecentSearch(grocery.name);
  }

  Future<List<String>> getRecentSearches(String value) {
    return localDataSource
        .getRecentSearches(value)
        .then((searches) => searches.map((s) => s.query).toList());
  }
}
