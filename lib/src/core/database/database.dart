import 'dart:io' as io;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/src/core/database/database.drift.dart';
import 'package:todo_list/src/core/database/groceries_table.dart';
import 'package:todo_list/src/core/database/groceries_table.drift.dart';
import 'package:todo_list/src/core/database/recent_searches_table.dart';
import 'package:todo_list/src/core/database/recent_searches_table.drift.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';

@DriftDatabase(tables: [GroceriesTable, RecentSearchesTable])
class AppDatabase extends $AppDatabase {
  new() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = io.File(p.join(dir.path, 'appdb.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}

final appDatabaseProvider = Provider<AppDatabase>((_) => AppDatabase());

extension DbGroceriesExt on GroceriesTableData {
  Grocery toEntity() => Grocery(
    id: id,
    order: order,
    name: name,
    completed: completed,
    quantity: quantity,
  );
}

extension DbRecentSearchesExt on RecentSearchesTableData {
  RecentSearch toEntity() => RecentSearch(query: query, timestamp: timestamp);
}
