import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/src/core/models/grocery_list.dart';
import 'package:todo_list/src/core/models/id.dart';

part 'grocery.freezed.dart';

typedef GroceryId = IntId<Grocery>;

@freezed
abstract class Grocery with _$Grocery {
  const factory({
    required GroceryId id,
    required String name,
    required DateTime updatedAt,
    @Default(GroceryListId(0)) GroceryListId listId,
    @Default(0) int order,
    @Default(false) bool completed,
  }) = _Grocery;
}
