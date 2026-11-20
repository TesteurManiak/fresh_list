import 'package:drift/drift.dart';
import 'package:fresh_list/src/core/database/recent_searches_table.drift.dart';
import 'package:fresh_list/src/core/models/recent_search.dart';

class RecentSearchesTable extends Table {
  TextColumn get query => text()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {query};
}

extension DbRecentSearchesExt on RecentSearchesTableData {
  RecentSearch toEntity() => RecentSearch(query: query, timestamp: timestamp);
}
