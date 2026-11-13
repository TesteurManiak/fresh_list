import 'package:drift/drift.dart';
import 'package:todo_list/src/core/database/groceries_table.drift.dart';
import 'package:todo_list/src/core/database/shopping_lists_table.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/id.dart';

@TableIndex(name: 'grocery_index', columns: {#order})
class GroceriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listId => integer().references(ShoppingListsTable, #id)();
  IntColumn get order => integer()();
  TextColumn get name => text()();
  BoolColumn get completed => boolean()();

  // Deterministic Last-Write-Wins (LWW) merging
  DateTimeColumn get updatedAt => dateTime()();

  // Soft-delete tombstone: null = active, timestamp = deleted
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

extension DbGroceriesExt on GroceriesTableData {
  Grocery toEntity() => Grocery(
    id: IntId(id),
    listId: IntId(listId),
    order: order,
    name: name,
    completed: completed,
  );
}
