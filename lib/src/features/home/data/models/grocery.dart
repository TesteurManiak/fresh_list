import 'package:dart_mappable/dart_mappable.dart';

part 'grocery.mapper.dart';

@MappableClass()
class Grocery with GroceryMappable {
  const Grocery({
    required this.index,
    required this.name,
    this.quantity,
  });

  final int index;
  final String name;
  final double? quantity;
}
