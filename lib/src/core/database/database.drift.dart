// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:fresh_list/src/core/database/shopping_lists_table.drift.dart'
    as i1;
import 'package:fresh_list/src/core/database/groceries_table.drift.dart' as i2;
import 'package:fresh_list/src/core/database/recent_searches_table.drift.dart'
    as i3;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  late final i1.$ShoppingListsTableTable shoppingListsTable = i1
      .$ShoppingListsTableTable(this);
  late final i2.$GroceriesTableTable groceriesTable = i2.$GroceriesTableTable(
    this,
  );
  late final i3.$RecentSearchesTableTable recentSearchesTable = i3
      .$RecentSearchesTableTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    shoppingListsTable,
    groceriesTable,
    recentSearchesTable,
    i2.groceryIndex,
  ];
}
