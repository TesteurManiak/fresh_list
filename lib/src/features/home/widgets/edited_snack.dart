import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/widgets/app_snack.dart';

class const EditedSnack(final String newContent) extends AppSnack {
  @override
  SnackBarBuilder build(BuildContext context) {
    return SnackBarBuilder()
      // TODO(Guillaume): localize
      ..text = 'Edited: $newContent'
      ..icon = Icons.edit;
  }
}
