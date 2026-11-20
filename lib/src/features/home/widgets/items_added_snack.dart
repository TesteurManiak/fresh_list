import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/widgets/app_snack.dart';
import 'package:material_ui/material_ui.dart';

class const ItemsAddedSnack(final int added) extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    final strings = context.strings;
    return SnackBarBuilder()
      ..text = strings.nearby_items_added(added)
      ..icon = Icons.playlist_add_check_rounded;
  }
}
