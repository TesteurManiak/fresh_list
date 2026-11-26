import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:fresh_list/src/core/database/database.dart';

class AppMigrationStrategy(final AppDatabase db) extends MigrationStrategy {
  @override
  OnUpgrade get onUpgrade => _onUpgrade;

  Future<void> _onUpgrade(Migrator m, int from, int to) async {
    log('Migrating database from $from to $to', name: 'drift');

    // Downgrade
    if (from > to) {
      await _resetDatabase(m);
    }
  }

  Future<void> _resetDatabase(Migrator m) async {
    log('Resetting database', name: 'drift');

    final allSchemaEntities = m.database.allSchemaEntities;
    for (final entity in allSchemaEntities) {
      await m.drop(entity);
    }

    await m.createAll();
  }
}
