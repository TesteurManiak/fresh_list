// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DbGroceriesTable extends DbGroceries
    with TableInfo<$DbGroceriesTable, DbGrocery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbGroceriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [order, name, completed, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_groceries';
  @override
  VerificationContext validateIntegrity(Insertable<DbGrocery> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {order};
  @override
  DbGrocery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbGrocery(
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
    );
  }

  @override
  $DbGroceriesTable createAlias(String alias) {
    return $DbGroceriesTable(attachedDatabase, alias);
  }
}

class DbGrocery extends DataClass implements Insertable<DbGrocery> {
  final int order;
  final String name;
  final bool completed;
  final double? quantity;
  const DbGrocery(
      {required this.order,
      required this.name,
      required this.completed,
      this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order'] = Variable<int>(order);
    map['name'] = Variable<String>(name);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    return map;
  }

  DbGroceriesCompanion toCompanion(bool nullToAbsent) {
    return DbGroceriesCompanion(
      order: Value(order),
      name: Value(name),
      completed: Value(completed),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
    );
  }

  factory DbGrocery.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbGrocery(
      order: serializer.fromJson<int>(json['order']),
      name: serializer.fromJson<String>(json['name']),
      completed: serializer.fromJson<bool>(json['completed']),
      quantity: serializer.fromJson<double?>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'order': serializer.toJson<int>(order),
      'name': serializer.toJson<String>(name),
      'completed': serializer.toJson<bool>(completed),
      'quantity': serializer.toJson<double?>(quantity),
    };
  }

  DbGrocery copyWith(
          {int? order,
          String? name,
          bool? completed,
          Value<double?> quantity = const Value.absent()}) =>
      DbGrocery(
        order: order ?? this.order,
        name: name ?? this.name,
        completed: completed ?? this.completed,
        quantity: quantity.present ? quantity.value : this.quantity,
      );
  @override
  String toString() {
    return (StringBuffer('DbGrocery(')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('completed: $completed, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(order, name, completed, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbGrocery &&
          other.order == this.order &&
          other.name == this.name &&
          other.completed == this.completed &&
          other.quantity == this.quantity);
}

class DbGroceriesCompanion extends UpdateCompanion<DbGrocery> {
  final Value<int> order;
  final Value<String> name;
  final Value<bool> completed;
  final Value<double?> quantity;
  const DbGroceriesCompanion({
    this.order = const Value.absent(),
    this.name = const Value.absent(),
    this.completed = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  DbGroceriesCompanion.insert({
    this.order = const Value.absent(),
    required String name,
    required bool completed,
    this.quantity = const Value.absent(),
  })  : name = Value(name),
        completed = Value(completed);
  static Insertable<DbGrocery> custom({
    Expression<int>? order,
    Expression<String>? name,
    Expression<bool>? completed,
    Expression<double>? quantity,
  }) {
    return RawValuesInsertable({
      if (order != null) 'order': order,
      if (name != null) 'name': name,
      if (completed != null) 'completed': completed,
      if (quantity != null) 'quantity': quantity,
    });
  }

  DbGroceriesCompanion copyWith(
      {Value<int>? order,
      Value<String>? name,
      Value<bool>? completed,
      Value<double?>? quantity}) {
    return DbGroceriesCompanion(
      order: order ?? this.order,
      name: name ?? this.name,
      completed: completed ?? this.completed,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
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
      map['quantity'] = Variable<double>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbGroceriesCompanion(')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, query, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_recent_searches';
  @override
  VerificationContext validateIntegrity(Insertable<DbRecentSearche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbRecentSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRecentSearche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $DbRecentSearchesTable createAlias(String alias) {
    return $DbRecentSearchesTable(attachedDatabase, alias);
  }
}

class DbRecentSearche extends DataClass implements Insertable<DbRecentSearche> {
  final int id;
  final String query;
  final DateTime timestamp;
  const DbRecentSearche(
      {required this.id, required this.query, required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query'] = Variable<String>(query);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  DbRecentSearchesCompanion toCompanion(bool nullToAbsent) {
    return DbRecentSearchesCompanion(
      id: Value(id),
      query: Value(query),
      timestamp: Value(timestamp),
    );
  }

  factory DbRecentSearche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRecentSearche(
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  DbRecentSearche copyWith({int? id, String? query, DateTime? timestamp}) =>
      DbRecentSearche(
        id: id ?? this.id,
        query: query ?? this.query,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('DbRecentSearche(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, query, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRecentSearche &&
          other.id == this.id &&
          other.query == this.query &&
          other.timestamp == this.timestamp);
}

class DbRecentSearchesCompanion extends UpdateCompanion<DbRecentSearche> {
  final Value<int> id;
  final Value<String> query;
  final Value<DateTime> timestamp;
  const DbRecentSearchesCompanion({
    this.id = const Value.absent(),
    this.query = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  DbRecentSearchesCompanion.insert({
    this.id = const Value.absent(),
    required String query,
    required DateTime timestamp,
  })  : query = Value(query),
        timestamp = Value(timestamp);
  static Insertable<DbRecentSearche> custom({
    Expression<int>? id,
    Expression<String>? query,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (query != null) 'query': query,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  DbRecentSearchesCompanion copyWith(
      {Value<int>? id, Value<String>? query, Value<DateTime>? timestamp}) {
    return DbRecentSearchesCompanion(
      id: id ?? this.id,
      query: query ?? this.query,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbRecentSearchesCompanion(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $DbGroceriesTable dbGroceries = $DbGroceriesTable(this);
  late final $DbRecentSearchesTable dbRecentSearches =
      $DbRecentSearchesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbGroceries, dbRecentSearches];
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'92a246abcb363d93aa5a028712241f464abc4efe';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppDatabaseRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
