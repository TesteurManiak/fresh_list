import 'dart:convert';
import 'dart:typed_data';

import 'package:fresh_list/src/core/models/grocery.dart';

typedef SharedGrocery = ({String name, bool completed});

/// JSON wire format of a grocery list sent through nearby sharing.
///
/// Only the name and completion are sent: ids, list and order are local to
/// each device.
abstract final class SharedGroceryListCodec {
  static const version = 1;

  // Received bytes come from another device: bound what we accept.
  static const maxItems = 500;
  static const maxNameLength = 200;

  static Uint8List encode(Iterable<Grocery> groceries) {
    return utf8.encode(
      jsonEncode({
        'version': version,
        'items': [
          for (final g in groceries) {'name': g.name, 'completed': g.completed},
        ],
      }),
    );
  }

  /// Throws a [FormatException] for anything [encode] would not produce.
  static List<SharedGrocery> decode(Uint8List bytes) {
    final json = jsonDecode(utf8.decode(bytes));
    if (json
        case {
          'version': SharedGroceryListCodec.version,
          'items': final List<Object?> items,
        }
        when items.length <= maxItems) {
      return [
        for (final item in items)
          switch (item) {
            {'name': final String name, 'completed': final bool completed}
                when name.trim().isNotEmpty && name.length <= maxNameLength =>
              (name: name.trim(), completed: completed),
            _ => throw const FormatException('Invalid grocery item'),
          },
      ];
    }
    throw const FormatException('Unsupported grocery list payload');
  }
}
