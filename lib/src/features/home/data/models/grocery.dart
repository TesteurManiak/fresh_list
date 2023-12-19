import 'package:dart_mappable/dart_mappable.dart';
import 'package:isar/isar.dart';

part 'grocery.g.dart';
part 'grocery.mapper.dart';

@Collection(accessor: 'groceries')
@Name('Groceries')
@MappableClass()
class Grocery with GroceryMappable {
  Grocery({
    required this.order,
    required this.name,
    required this.completed,
    this.quantity,
  });

  Id? id;

  @Index(unique: true, replace: true)
  final int order;
  final String name;
  final bool completed;
  final double? quantity;
}
