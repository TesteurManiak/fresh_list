import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/mixins/hook.dart';
import 'package:fresh_list/src/core/utils/haptics_helper.dart';
import 'package:fresh_list/src/core/widgets/app_icon.dart';
import 'package:fresh_list/src/core/widgets/bottom_padding.dart';
import 'package:fresh_list/src/features/home/notifiers/grocery_list_notifier.dart';
import 'package:fresh_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';
import 'package:fresh_list/src/features/home/widgets/grocery_tile.dart';
import 'package:fresh_list/src/features/home/widgets/list_title.dart';
import 'package:fresh_list/src/features/home/widgets/nearby_sharing_bottom_sheet.dart';
import 'package:fresh_list/src/features/settings/navigation/settings_route.dart';
import 'package:material_ui/material_ui.dart';

class HomeView extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with HookMixin {
  late final scrollController = useScrollController();

  @override
  Widget build(BuildContext context) {
    final groceriesValue = ref.watch(groceryListNotifierProvider);
    final strings = context.strings;

    // Hands the custom controller to the Scaffold so that tapping the iOS
    // status bar still scrolls the list to the top.
    return PrimaryScrollController(
      controller: scrollController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              AppIcon(),
              Flexible(child: ListTitle()),
            ],
          ),
          actions: [
            IconButton(
              tooltip: strings.quick_action_share,
              icon: const Icon(Icons.offline_share_rounded),
              onPressed: () => const NearbySharingBottomSheet().show(context),
            ),
            IconButton(
              key: const Key('settings_button'),
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
                  .read(groceryListNotifierProvider.notifier)
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
              proxyDecorator: (child, index, animation) {
                final item = data[index];
                return proxyDecorator(
                  child,
                  index,
                  animation,
                  GroceryTile.radiusFor(index, data.length, item.completed),
                );
              },
              itemBuilder: (_, i) {
                final g = data[i];
                return GroceryTile(
                  g,
                  key: Key('Reorderable-${g.id}'),
                  borderRadius: GroceryTile.radiusFor(
                    i,
                    data.length,
                    g.completed,
                  ),
                );
              },
              itemCount: data.length,
              onReorderStart: (_) => HapticsHelper.medium(),
              onReorderEnd: (_) => HapticsHelper.light(),
              onReorderItem: (oldIndex, newIndex) => ref
                  .read(groceryListNotifierProvider.notifier)
                  .reorder(oldIndex, newIndex),
            );
          },
          error: (e, s) {
            log(e.toString(), error: e, stackTrace: s);
            return _CenteredText(strings.generic_error);
          },
          loading: () => Center(child: LoadingIndicator()),
        ),
      ),
    );
  }

  Widget proxyDecorator(
    Widget child,
    int index,
    Animation<double> animation,
    BorderRadius currentBorderRadius,
  ) {
    final endingBorderRadius = BorderRadius.circular(GroceryTile.outerRadius);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 4, value) ?? 0;
        final borderRadius =
            BorderRadius.lerp(currentBorderRadius, endingBorderRadius, value) ??
            endingBorderRadius;

        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.black.withValues(alpha: .3),
          borderRadius: borderRadius,
          child: ClipRRect(borderRadius: borderRadius, child: child),
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
    final textTheme = TextTheme.of(context);

    return Center(
      child: Padding(
        padding: const .all(16),
        child: Text(text, style: textTheme.titleLarge, textAlign: .center),
      ),
    );
  }
}
