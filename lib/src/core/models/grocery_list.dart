import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fresh_list/src/core/models/id.dart';

part 'grocery_list.freezed.dart';

typedef GroceryListId = IntId<GroceryList>;

@freezed
abstract class GroceryList with _$GroceryList {
  const factory({required GroceryListId id, @Default('') String name}) =
      _GroceryList;
}
