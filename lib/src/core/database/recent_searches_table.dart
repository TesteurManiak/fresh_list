import 'package:drift/drift.dart';

class RecentSearchesTable extends Table {
  TextColumn get query => text()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {query};
}
