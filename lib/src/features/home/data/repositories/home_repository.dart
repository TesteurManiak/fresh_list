import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(ref);
}

class HomeRepository {
  const HomeRepository(this.ref);

  final HomeRepositoryRef ref;

  Future<void> updateGroceries(List<Grocery> groceries) async {
    await ref.read(homeLocalDatasourceProvider).updateGroceries(groceries);
  }

  Future<void> addGrocery(Grocery grocery) async {
    await ref.read(homeLocalDatasourceProvider).addGrocery(grocery);
  }
}
