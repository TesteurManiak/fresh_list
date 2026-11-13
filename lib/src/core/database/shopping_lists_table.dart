import 'package:drift/drift.dart';

class ShoppingListsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
