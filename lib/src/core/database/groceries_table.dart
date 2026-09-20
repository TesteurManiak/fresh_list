import 'package:drift/drift.dart';
import 'package:todo_list/src/core/database/groceries_table.drift.dart';
import 'package:todo_list/src/core/models/grocery.dart';

@TableIndex(name: 'grocery_index', columns: {#order})
class GroceriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get order => integer()();
  TextColumn get name => text()();
  BoolColumn get completed => boolean()();
}

extension DbGroceriesExt on GroceriesTableData {
  Grocery toEntity() =>
      Grocery(id: id, order: order, name: name, completed: completed);
}
