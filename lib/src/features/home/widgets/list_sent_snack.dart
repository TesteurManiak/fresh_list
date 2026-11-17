import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class const ListSentSnack(final String peer) extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    final strings = context.strings;
    return SnackBarBuilder()
      ..text = strings.nearby_list_sent(peer)
      ..icon = Icons.send_rounded;
  }
}
