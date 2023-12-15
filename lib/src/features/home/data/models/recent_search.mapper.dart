// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'recent_search.dart';

class RecentSearchMapper extends ClassMapperBase<RecentSearch> {
  RecentSearchMapper._();

  static RecentSearchMapper? _instance;
  static RecentSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RecentSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RecentSearch';

  static String _$query(RecentSearch v) => v.query;
  static const Field<RecentSearch, String> _f$query = Field('query', _$query);
  static DateTime _$timestamp(RecentSearch v) => v.timestamp;
  static const Field<RecentSearch, DateTime> _f$timestamp =
      Field('timestamp', _$timestamp);
  static int? _$id(RecentSearch v) => v.id;
  static const Field<RecentSearch, int> _f$id =
      Field('id', _$id, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<RecentSearch, dynamic>> fields = const {
    #query: _f$query,
    #timestamp: _f$timestamp,
    #id: _f$id,
  };

  static RecentSearch _instantiate(DecodingData data) {
    return RecentSearch(
        query: data.dec(_f$query), timestamp: data.dec(_f$timestamp));
  }

  @override
  final Function instantiate = _instantiate;

  static RecentSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RecentSearch>(map);
  }

  static RecentSearch fromJson(String json) {
    return ensureInitialized().decodeJson<RecentSearch>(json);
  }
}

mixin RecentSearchMappable {
  String toJson() {
    return RecentSearchMapper.ensureInitialized()
        .encodeJson<RecentSearch>(this as RecentSearch);
  }

  Map<String, dynamic> toMap() {
    return RecentSearchMapper.ensureInitialized()
        .encodeMap<RecentSearch>(this as RecentSearch);
  }

  RecentSearchCopyWith<RecentSearch, RecentSearch, RecentSearch> get copyWith =>
      _RecentSearchCopyWithImpl(this as RecentSearch, $identity, $identity);
  @override
  String toString() {
    return RecentSearchMapper.ensureInitialized()
        .stringifyValue(this as RecentSearch);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RecentSearchMapper.ensureInitialized()
                .isValueEqual(this as RecentSearch, other));
  }

  @override
  int get hashCode {
    return RecentSearchMapper.ensureInitialized()
        .hashValue(this as RecentSearch);
  }
}

extension RecentSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RecentSearch, $Out> {
  RecentSearchCopyWith<$R, RecentSearch, $Out> get $asRecentSearch =>
      $base.as((v, t, t2) => _RecentSearchCopyWithImpl(v, t, t2));
}

abstract class RecentSearchCopyWith<$R, $In extends RecentSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? query, DateTime? timestamp});
  RecentSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RecentSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RecentSearch, $Out>
    implements RecentSearchCopyWith<$R, RecentSearch, $Out> {
  _RecentSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RecentSearch> $mapper =
      RecentSearchMapper.ensureInitialized();
  @override
  $R call({String? query, DateTime? timestamp}) => $apply(FieldCopyWithData({
        if (query != null) #query: query,
        if (timestamp != null) #timestamp: timestamp
      }));
  @override
  RecentSearch $make(CopyWithData data) => RecentSearch(
      query: data.get(#query, or: $value.query),
      timestamp: data.get(#timestamp, or: $value.timestamp));

  @override
  RecentSearchCopyWith<$R2, RecentSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RecentSearchCopyWithImpl($value, $cast, t);
}
