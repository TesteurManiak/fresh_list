// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:fresh_list/src/core/database/recent_searches_table.drift.dart'
    as i1;
import 'package:fresh_list/src/core/database/recent_searches_table.dart' as i2;

class $RecentSearchesTableTable extends i2.RecentSearchesTable
    with i0.TableInfo<$RecentSearchesTableTable, i1.RecentSearchesTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentSearchesTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _queryMeta = const i0.VerificationMeta(
    'query',
  );
  @override
  late final i0.GeneratedColumn<String> query = i0.GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _timestampMeta = const i0.VerificationMeta(
    'timestamp',
  );
  @override
  late final i0.GeneratedColumn<DateTime> timestamp =
      i0.GeneratedColumn<DateTime>(
        'timestamp',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [query, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_searches_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.RecentSearchesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
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
  Set<i0.GeneratedColumn> get $primaryKey => {query};
  @override
  i1.RecentSearchesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.RecentSearchesTableData(
      query: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $RecentSearchesTableTable createAlias(String alias) {
    return $RecentSearchesTableTable(attachedDatabase, alias);
  }
}

class RecentSearchesTableData extends i0.DataClass
    implements i0.Insertable<i1.RecentSearchesTableData> {
  final String query;
  final DateTime timestamp;
  const RecentSearchesTableData({required this.query, required this.timestamp});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['query'] = i0.Variable<String>(query);
    map['timestamp'] = i0.Variable<DateTime>(timestamp);
    return map;
  }

  factory RecentSearchesTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return RecentSearchesTableData(
      query: serializer.fromJson<String>(json['query']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  i1.RecentSearchesTableData copyWith({String? query, DateTime? timestamp}) =>
      i1.RecentSearchesTableData(
        query: query ?? this.query,
        timestamp: timestamp ?? this.timestamp,
      );
  RecentSearchesTableData copyWithCompanion(
    i1.RecentSearchesTableCompanion data,
  ) {
    return RecentSearchesTableData(
      query: data.query.present ? data.query.value : this.query,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentSearchesTableData(')
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
      (other is i1.RecentSearchesTableData &&
          other.query == this.query &&
          other.timestamp == this.timestamp);
}

class RecentSearchesTableCompanion
    extends i0.UpdateCompanion<i1.RecentSearchesTableData> {
  final i0.Value<String> query;
  final i0.Value<DateTime> timestamp;
  final i0.Value<int> rowid;
  const RecentSearchesTableCompanion({
    this.query = const i0.Value.absent(),
    this.timestamp = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  RecentSearchesTableCompanion.insert({
    required String query,
    required DateTime timestamp,
    this.rowid = const i0.Value.absent(),
  }) : query = i0.Value(query),
       timestamp = i0.Value(timestamp);
  static i0.Insertable<i1.RecentSearchesTableData> custom({
    i0.Expression<String>? query,
    i0.Expression<DateTime>? timestamp,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (query != null) 'query': query,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.RecentSearchesTableCompanion copyWith({
    i0.Value<String>? query,
    i0.Value<DateTime>? timestamp,
    i0.Value<int>? rowid,
  }) {
    return i1.RecentSearchesTableCompanion(
      query: query ?? this.query,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (query.present) {
      map['query'] = i0.Variable<String>(query.value);
    }
    if (timestamp.present) {
      map['timestamp'] = i0.Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentSearchesTableCompanion(')
          ..write('query: $query, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
