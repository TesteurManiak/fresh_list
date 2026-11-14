import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_wavy_progress_indicator/material_wavy_progress_indicator.dart';
import 'package:todo_list/src/core/constants/consts.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/hook.dart';
import 'package:todo_list/src/core/utils/haptics_helper.dart';
import 'package:todo_list/src/core/widgets/app_icon.dart';
import 'package:todo_list/src/core/widgets/bottom_padding.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';
import 'package:todo_list/src/features/home/widgets/grocery_tile.dart';
import 'package:todo_list/src/features/settings/navigation/settings_route.dart';

class HomeView extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with HookMixin {
  late final scrollController = useScrollController();

  @override
  Widget build(BuildContext context) {
    final groceriesValue = ref.watch(groceryListControllerProvider);
    final strings = context.strings;

    // Hands the custom controller to the Scaffold so that tapping the iOS
    // status bar still scrolls the list to the top.
    return PrimaryScrollController(
      controller: scrollController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [AppIcon(), Text(AppConstants.appName)],
          ),
          actions: [
            IconButton(
              tooltip: strings.quick_action_share,
              icon: const Icon(Icons.publish),
              onPressed: () =>
                  ref.read(groceryListControllerProvider.notifier).shareList(),
            ),
            IconButton(
              tooltip: strings.settings_title,
              icon: const Icon(Icons.tune),
              onPressed: () => const SettingsRoute().go(context),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: strings.add_grocery,
          onPressed: () async {
            unawaited(HapticsHelper.light());
            final grocery = await const EditGroceryBottomSheet().show(context);
            if (grocery != null) {
              await ref
                  .read(groceryListControllerProvider.notifier)
                  .createGrocery(grocery);

              if (!scrollController.hasClients) return;

              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          child: const Icon(Icons.add),
        ),
        body: groceriesValue.when(
          skipLoadingOnReload: true,
          data: (data) {
            if (data.isEmpty) return _CenteredText(strings.empty_grocery_list);

            return ReorderableListView.builder(
              scrollController: scrollController,
              // Clears the FAB (56dp + 16dp margin) and the system bar.
              padding: .only(
                left: 16,
                right: 16,
                bottom: BottomPadding.of(context) + 72,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              proxyDecorator: proxyDecorator,
              itemBuilder: (_, i) {
                final g = data[i];
                return GroceryTile(
                  g,
                  key: Key('Reorderable-${g.id}'),
                  showSwipeHint: i == 0,
                );
              },
              itemCount: data.length,
              onReorderStart: (_) => unawaited(HapticsHelper.medium()),
              onReorderEnd: (_) => unawaited(HapticsHelper.light()),
              onReorderItem: (oldIndex, newIndex) => ref
                  .read(groceryListControllerProvider.notifier)
                  .reorder(oldIndex, newIndex),
            );
          },
          error: (e, s) {
            log(e.toString(), error: e, stackTrace: s);
            return _CenteredText(strings.generic_error);
          },
          loading: () => const Center(child: CircularWavyProgressIndicator()),
        ),
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 6, value) ?? 0;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.black.withValues(alpha: 0.3),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _CenteredText extends StatelessWidget {
  const new(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
