import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/widgets/app_sheet.dart';

class NearbySharingBottomSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<void> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppSheet(child: CustomScrollView());
  }
}
