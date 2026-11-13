import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/mixins/showable.dart';

class RecentSearchActionsBottomSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<RecentSearchAction> {
  const new({super.key});

  @override
  bool get showDragHandle => true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final action in RecentSearchAction.values)
          ListTile(
            leading: Icon(action.icon),
            title: Text(action.label(strings)),
            onTap: () => Navigator.pop(context, action),
          ),
      ],
    );
  }
}

enum RecentSearchAction(final LocalizedString label, final IconData icon) {
  delete(_delete, Icons.delete);

  static String _delete(AppLocalizations strings) =>
      strings.quick_action_delete;
}
