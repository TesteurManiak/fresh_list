import 'dart:io' as io;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';

part 'database.g.dart';

class DbGroceries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get order => integer()();
  TextColumn get name => text()();
  BoolColumn get completed => boolean()();
  RealColumn get quantity => real().nullable()();
}

class DbRecentSearches extends Table {
  TextColumn get query => text()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {query};
}

@DriftDatabase(tables: [DbGroceries, DbRecentSearches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

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

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase();

extension DbGroceriesExt on DbGrocery {
  Grocery toModel() {
    return Grocery(
      id: id,
      order: order,
      name: name,
      completed: completed,
      quantity: quantity,
    );
  }
}

extension DbRecentSearchesExt on DbRecentSearche {
  RecentSearch toModel() {
    return RecentSearch(query: query, timestamp: timestamp);
  }
}
