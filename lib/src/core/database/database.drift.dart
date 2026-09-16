// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:todo_list/src/core/database/groceries_table.drift.dart' as i1;
import 'package:todo_list/src/core/database/recent_searches_table.drift.dart'
    as i2;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  late final i1.$GroceriesTableTable groceriesTable = i1.$GroceriesTableTable(
    this,
  );
  late final i2.$RecentSearchesTableTable recentSearchesTable = i2
      .$RecentSearchesTableTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    groceriesTable,
    recentSearchesTable,
    i1.groceryIndex,
  ];
}
