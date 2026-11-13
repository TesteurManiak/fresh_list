import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/showable.dart';

class ClearAllConfirmationDialog extends StatelessWidget
    with ShowableDialogMixin<bool> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return AlertDialog(
      title: Text(strings.clear_all_confirmation_title),
      content: Text(strings.clear_all_confirmation_message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(strings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(strings.clear_all),
        ),
      ],
    );
  }
}
