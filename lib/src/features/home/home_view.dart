import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/core/consts.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';
import 'package:todo_list/src/features/home/widgets/grocery_tile.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groceriesValue = ref.watch(groceryListControllerProvider);
    final strings = context.strings;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Consts.appName),
        leading: const IconButton(
          icon: Icon(Icons.share),
          // TODO(Guillaume): Implement share
          onPressed: null,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: strings.add_grocery,
        onPressed: () async {
          final grocery = await const EditGroceryBottomSheet().show(context);
          if (grocery != null) {
            await ref
                .read(groceryListControllerProvider.notifier)
                .createGrocery(grocery);

            if (!scrollController.hasClients) return;
            unawaited(
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      body: groceriesValue.when(
        data: (data) {
          if (data.isEmpty) {
            return _CenteredText(strings.empty_grocery_list);
          }

          return ReorderableListView.builder(
            scrollController: scrollController,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
            proxyDecorator: proxyDecorator,
            itemBuilder: (_, i) => GroceryTile(data[i], key: ValueKey(i)),
            itemCount: data.length,
            onReorder: (oldIndex, newIndex) {
              ref.read(groceryListControllerProvider.notifier).reorder(
                    oldIndex,
                    newIndex,
                  );
            },
          );
        },
        error: (_, __) => _CenteredText(strings.generic_error),
        loading: () => const Center(child: CupertinoActivityIndicator()),
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
          shadowColor: Colors.black.withOpacity(0.3),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _CenteredText extends StatelessWidget {
  const _CenteredText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
