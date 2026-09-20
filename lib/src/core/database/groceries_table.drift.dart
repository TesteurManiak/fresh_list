// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:todo_list/src/core/database/groceries_table.drift.dart' as i1;
import 'package:todo_list/src/core/database/groceries_table.dart' as i2;

i0.Index get groceryIndex => i0.Index(
  'grocery_index',
  'CREATE INDEX grocery_index ON groceries_table ("order")',
);

class $GroceriesTableTable extends i2.GroceriesTable
    with i0.TableInfo<$GroceriesTableTable, i1.GroceriesTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroceriesTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _orderMeta = const i0.VerificationMeta(
    'order',
  );
  @override
  late final i0.GeneratedColumn<int> order = i0.GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _nameMeta = const i0.VerificationMeta(
    'name',
  );
  @override
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _completedMeta = const i0.VerificationMeta(
    'completed',
  );
  @override
  late final i0.GeneratedColumn<bool> completed = i0.GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  @override
  List<i0.GeneratedColumn> get $columns => [id, order, name, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groceries_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.GroceriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
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
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.GroceriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.GroceriesTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $GroceriesTableTable createAlias(String alias) {
    return $GroceriesTableTable(attachedDatabase, alias);
  }
}

class GroceriesTableData extends i0.DataClass
    implements i0.Insertable<i1.GroceriesTableData> {
  final int id;
  final int order;
  final String name;
  final bool completed;
  const GroceriesTableData({
    required this.id,
    required this.order,
    required this.name,
    required this.completed,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['order'] = i0.Variable<int>(order);
    map['name'] = i0.Variable<String>(name);
    map['completed'] = i0.Variable<bool>(completed);
    return map;
  }

  factory GroceriesTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return GroceriesTableData(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      name: serializer.fromJson<String>(json['name']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'name': serializer.toJson<String>(name),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  i1.GroceriesTableData copyWith({
    int? id,
    int? order,
    String? name,
    bool? completed,
  }) => i1.GroceriesTableData(
    id: id ?? this.id,
    order: order ?? this.order,
    name: name ?? this.name,
    completed: completed ?? this.completed,
  );
  GroceriesTableData copyWithCompanion(i1.GroceriesTableCompanion data) {
    return GroceriesTableData(
      id: data.id.present ? data.id.value : this.id,
      order: data.order.present ? data.order.value : this.order,
      name: data.name.present ? data.name.value : this.name,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroceriesTableData(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, name, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.GroceriesTableData &&
          other.id == this.id &&
          other.order == this.order &&
          other.name == this.name &&
          other.completed == this.completed);
}

class GroceriesTableCompanion
    extends i0.UpdateCompanion<i1.GroceriesTableData> {
  final i0.Value<int> id;
  final i0.Value<int> order;
  final i0.Value<String> name;
  final i0.Value<bool> completed;
  const GroceriesTableCompanion({
    this.id = const i0.Value.absent(),
    this.order = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.completed = const i0.Value.absent(),
  });
  GroceriesTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required int order,
    required String name,
    required bool completed,
  }) : order = i0.Value(order),
       name = i0.Value(name),
       completed = i0.Value(completed);
  static i0.Insertable<i1.GroceriesTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? order,
    i0.Expression<String>? name,
    i0.Expression<bool>? completed,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (name != null) 'name': name,
      if (completed != null) 'completed': completed,
    });
  }

  i1.GroceriesTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<int>? order,
    i0.Value<String>? name,
    i0.Value<bool>? completed,
  }) {
    return i1.GroceriesTableCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = i0.Variable<int>(order.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (completed.present) {
      map['completed'] = i0.Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroceriesTableCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('name: $name, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}
