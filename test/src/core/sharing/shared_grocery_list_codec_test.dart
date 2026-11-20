import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_list/src/core/models/grocery.dart';
import 'package:fresh_list/src/core/sharing/shared_grocery_list_codec.dart';

void main() {
  Grocery grocery(String name, {bool completed = false}) => Grocery(
    id: const GroceryId(1),
    order: 0,
    name: name,
    updatedAt: DateTime(2026),
    completed: completed,
  );

  test('round-trips name and completion', () {
    final bytes = SharedGroceryListCodec.encode([
      grocery('Milk'),
      grocery('Eggs', completed: true),
    ]);

    expect(SharedGroceryListCodec.decode(bytes), [
      (name: 'Milk', completed: false),
      (name: 'Eggs', completed: true),
    ]);
  });

  test('rejects malformed or unexpected payloads', () {
    const item = '{"name": "a", "completed": false}';
    final invalid = [
      'not json',
      '{"version": 2, "items": []}',
      '{"version": 1}',
      '{"version": 1, "items": [{"name": 3, "completed": false}]}',
      '{"version": 1, "items": [{"name": "  ", "completed": false}]}',
      '{"version": 1, "items": [{"name": "${'a' * 201}", "completed": false}]}',
      '{"version": 1, "items": [${List.filled(501, item).join(',')}]}',
    ];

    for (final payload in invalid) {
      expect(
        () => SharedGroceryListCodec.decode(utf8.encode(payload)),
        throwsFormatException,
        reason: payload.length > 80 ? payload.substring(0, 80) : payload,
      );
    }
  });
}
