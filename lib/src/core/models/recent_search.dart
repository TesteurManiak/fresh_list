import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_search.freezed.dart';

@freezed
abstract class RecentSearch with _$RecentSearch {
  const factory RecentSearch({
    required String query,
    required DateTime timestamp,
  }) = _RecentSearch;
}
