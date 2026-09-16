import 'package:drift/drift.dart';

@TableIndex(name: 'grocery_index', columns: {#order})
class GroceriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get order => integer()();
  TextColumn get name => text()();
  BoolColumn get completed => boolean()();
  IntColumn get quantity => integer().nullable()();
}
