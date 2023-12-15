import 'package:dart_mappable/dart_mappable.dart';
import 'package:isar/isar.dart';

part 'recent_search.g.dart';
part 'recent_search.mapper.dart';

@Collection(accessor: 'recentSearches')
@Name('RecentSearches')
@MappableClass()
class RecentSearch with RecentSearchMappable {
  RecentSearch({
    required this.query,
    required this.timestamp,
  });

  Id? id;

  final String query;

  @Index()
  final DateTime timestamp;
}
