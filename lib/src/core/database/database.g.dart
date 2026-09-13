// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DbGroceriesTable extends DbGroceries
    with TableInfo<$DbGroceriesTable, DbGrocery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbGroceriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, order, name, completed, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_groceries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbGrocery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbGrocery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbGrocery(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      ),
    );
  }

  @override
  $DbGroceriesTable createAlias(String alias) {
    return $DbGroceriesTable(attachedDatabase, alias);
  }
}

class DbGrocery extends DataClass implements Insertable<DbGrocery> {
  final int id;
  final int order;
  final String name;
  final bool completed;
  final int? quantity;
  const DbGrocery({
    required this.id,
    required this.order,
    required this.name,
    required this.completed,
    this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order'] = Variable<int>(order);
    map['name'] = Variable<String>(name);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    return map;
  }

  DbGroceriesCompanion toCompanion(bool nullToAbsent) {
    return DbGroceriesCompanion(
      id: Value(id),
      order: Value(order),
      name: Value(name),
      completed: Value(completed),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
    );
  }

  factory DbGrocery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbGrocery(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      name: serializer.fromJson<String>(json['name']),
      completed: serializer.fromJson<bool>(json['completed']),
      quantity: serializer.fromJson<int?>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'name': serializer.toJson<String>(name),
      'completed': serializer.toJson<bool>(completed),
      'quantity': serializer.toJson<int?>(quantity),
    };
  }

  DbGrocery copyWith({
    int? id,
    int? order,
    String? name,
    bool? completed,
    Value<int?> quantity = const Value.absent(),
  }) => DbGrocery(
    id: id ?? this.id,
    order: order ?? this.order,
    name: name ?? this.name,
    completed: completed ?? this.completed,
    quantity: quantity.present ? quantity.value : this.quantity,
  );
  DbGrocery copyWithCompanion(DbGroceriesCompanion data) {
    return DbGrocery(
      id: data.id.present ? data.id.value : this.id,
      order: data.order.present ? data.order.value : this.order,
      name: data.name.present ? data.name.value : this.name,
      completed: data.completed.present ? data.completed.value : this.completed,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbGrocery(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('completed: $completed, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, name, completed, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbGrocery &&
          other.id == this.id &&
          other.order == this.order &&
          other.name == this.name &&
          other.completed == this.completed &&
          other.quantity == this.quantity);
}

class DbGroceriesCompanion extends UpdateCompanion<DbGrocery> {
  final Value<int> id;
  final Value<int> order;
  final Value<String> name;
  final Value<bool> completed;
  final Value<int?> quantity;
  const DbGroceriesCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.name = const Value.absent(),
    this.completed = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  DbGroceriesCompanion.insert({
    this.id = const Value.absent(),
    required int order,
    required String name,
    required bool completed,
    this.quantity = const Value.absent(),
  }) : order = Value(order),
       name = Value(name),
       completed = Value(completed);
  static Insertable<DbGrocery> custom({
    Expression<int>? id,
    Expression<int>? order,
    Expression<String>? name,
    Expression<bool>? completed,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (name != null) 'name': name,
      if (completed != null) 'completed': completed,
      if (quantity != null) 'quantity': quantity,
    });
  }

  DbGroceriesCompanion copyWith({
    Value<int>? id,
    Value<int>? order,
    Value<String>? name,
    Value<bool>? completed,
    Value<int?>? quantity,
  }) {
    return DbGroceriesCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      completed: completed ?? this.completed,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbGroceriesCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('completed: $completed, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $DbRecentSearchesTable extends DbRecentSearches
    with TableInfo<$DbRecentSearchesTable, DbRecentSearche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbRecentSearchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [query, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_recent_searches';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbRecentSearche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {query};
  @override
  DbRecentSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRecentSearche(
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $DbRecentSearchesTable createAlias(String alias) {
    return $DbRecentSearchesTable(attachedDatabase, alias);
  }
}

class DbRecentSearche extends DataClass implements Insertable<DbRecentSearche> {
  final String query;
  final DateTime timestamp;
  const DbRecentSearche({required this.query, required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query'] = Variable<String>(query);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  DbRecentSearchesCompanion toCompanion(bool nullToAbsent) {
    return DbRecentSearchesCompanion(
      query: Value(query),
      timestamp: Value(timestamp),
    );
  }

  factory DbRecentSearche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRecentSearche(
      query: serializer.fromJson<String>(json['query']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  DbRecentSearche copyWith({String? query, DateTime? timestamp}) =>
      DbRecentSearche(
        query: query ?? this.query,
        timestamp: timestamp ?? this.timestamp,
      );
  DbRecentSearche copyWithCompanion(DbRecentSearchesCompanion data) {
    return DbRecentSearche(
      query: data.query.present ? data.query.value : this.query,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbRecentSearche(')
          ..write('query: $query, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(query, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRecentSearche &&
          other.query == this.query &&
          other.timestamp == this.timestamp);
}

class DbRecentSearchesCompanion extends UpdateCompanion<DbRecentSearche> {
  final Value<String> query;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const DbRecentSearchesCompanion({
    this.query = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbRecentSearchesCompanion.insert({
    required String query,
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  }) : query = Value(query),
       timestamp = Value(timestamp);
  static Insertable<DbRecentSearche> custom({
    Expression<String>? query,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (query != null) 'query': query,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbRecentSearchesCompanion copyWith({
    Value<String>? query,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return DbRecentSearchesCompanion(
      query: query ?? this.query,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbRecentSearchesCompanion(')
          ..write('query: $query, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbGroceriesTable dbGroceries = $DbGroceriesTable(this);
  late final $DbRecentSearchesTable dbRecentSearches = $DbRecentSearchesTable(
    this,
  );
  late final Index groceryIndex = Index(
    'grocery_index',
    'CREATE INDEX grocery_index ON db_groceries ("order")',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbGroceries,
    dbRecentSearches,
    groceryIndex,
  ];
}

typedef $$DbGroceriesTableCreateCompanionBuilder =
    DbGroceriesCompanion Function({
      Value<int> id,
      required int order,
      required String name,
      required bool completed,
      Value<int?> quantity,
    });
typedef $$DbGroceriesTableUpdateCompanionBuilder =
    DbGroceriesCompanion Function({
      Value<int> id,
      Value<int> order,
      Value<String> name,
      Value<bool> completed,
      Value<int?> quantity,
    });

class $$DbGroceriesTableFilterComposer
    extends Composer<_$AppDatabase, $DbGroceriesTable> {
  $$DbGroceriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbGroceriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbGroceriesTable> {
  $$DbGroceriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbGroceriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbGroceriesTable> {
  $$DbGroceriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$DbGroceriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbGroceriesTable,
          DbGrocery,
          $$DbGroceriesTableFilterComposer,
          $$DbGroceriesTableOrderingComposer,
          $$DbGroceriesTableAnnotationComposer,
          $$DbGroceriesTableCreateCompanionBuilder,
          $$DbGroceriesTableUpdateCompanionBuilder,
          (
            DbGrocery,
            BaseReferences<_$AppDatabase, $DbGroceriesTable, DbGrocery>,
          ),
          DbGrocery,
          PrefetchHooks Function()
        > {
  $$DbGroceriesTableTableManager(_$AppDatabase db, $DbGroceriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbGroceriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbGroceriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbGroceriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
              }) => DbGroceriesCompanion(
                id: id,
                order: order,
                name: name,
                completed: completed,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int order,
                required String name,
                required bool completed,
                Value<int?> quantity = const Value.absent(),
              }) => DbGroceriesCompanion.insert(
                id: id,
                order: order,
                name: name,
                completed: completed,
                quantity: quantity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbGroceriesTable, DbGrocery>(table),
                  BaseReferences<_$AppDatabase, $DbGroceriesTable, DbGrocery>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbGroceriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbGroceriesTable,
      DbGrocery,
      $$DbGroceriesTableFilterComposer,
      $$DbGroceriesTableOrderingComposer,
      $$DbGroceriesTableAnnotationComposer,
      $$DbGroceriesTableCreateCompanionBuilder,
      $$DbGroceriesTableUpdateCompanionBuilder,
      (DbGrocery, BaseReferences<_$AppDatabase, $DbGroceriesTable, DbGrocery>),
      DbGrocery,
      PrefetchHooks Function()
    >;
typedef $$DbRecentSearchesTableCreateCompanionBuilder =
    DbRecentSearchesCompanion Function({
      required String query,
      required DateTime timestamp,
      Value<int> rowid,
    });
typedef $$DbRecentSearchesTableUpdateCompanionBuilder =
    DbRecentSearchesCompanion Function({
      Value<String> query,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

class $$DbRecentSearchesTableFilterComposer
    extends Composer<_$AppDatabase, $DbRecentSearchesTable> {
  $$DbRecentSearchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbRecentSearchesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbRecentSearchesTable> {
  $$DbRecentSearchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbRecentSearchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbRecentSearchesTable> {
  $$DbRecentSearchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$DbRecentSearchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbRecentSearchesTable,
          DbRecentSearche,
          $$DbRecentSearchesTableFilterComposer,
          $$DbRecentSearchesTableOrderingComposer,
          $$DbRecentSearchesTableAnnotationComposer,
          $$DbRecentSearchesTableCreateCompanionBuilder,
          $$DbRecentSearchesTableUpdateCompanionBuilder,
          (
            DbRecentSearche,
            BaseReferences<
              _$AppDatabase,
              $DbRecentSearchesTable,
              DbRecentSearche
            >,
          ),
          DbRecentSearche,
          PrefetchHooks Function()
        > {
  $$DbRecentSearchesTableTableManager(
    _$AppDatabase db,
    $DbRecentSearchesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbRecentSearchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbRecentSearchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbRecentSearchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> query = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbRecentSearchesCompanion(
                query: query,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String query,
                required DateTime timestamp,
                Value<int> rowid = const Value.absent(),
              }) => DbRecentSearchesCompanion.insert(
                query: query,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbRecentSearchesTable, DbRecentSearche>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DbRecentSearchesTable,
                    DbRecentSearche
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbRecentSearchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbRecentSearchesTable,
      DbRecentSearche,
      $$DbRecentSearchesTableFilterComposer,
      $$DbRecentSearchesTableOrderingComposer,
      $$DbRecentSearchesTableAnnotationComposer,
      $$DbRecentSearchesTableCreateCompanionBuilder,
      $$DbRecentSearchesTableUpdateCompanionBuilder,
      (
        DbRecentSearche,
        BaseReferences<_$AppDatabase, $DbRecentSearchesTable, DbRecentSearche>,
      ),
      DbRecentSearche,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbGroceriesTableTableManager get dbGroceries =>
      $$DbGroceriesTableTableManager(_db, _db.dbGroceries);
  $$DbRecentSearchesTableTableManager get dbRecentSearches =>
      $$DbRecentSearchesTableTableManager(_db, _db.dbRecentSearches);
}
