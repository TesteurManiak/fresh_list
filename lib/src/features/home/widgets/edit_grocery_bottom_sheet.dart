import 'dart:async';

import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/clock.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/hook.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/models/recent_search.dart';
import 'package:todo_list/src/core/widgets/app_sheet.dart';
import 'package:todo_list/src/core/widgets/tile_icon.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/data/sources/home_local_datasource.dart';
import 'package:todo_list/src/features/home/widgets/recent_search_actions_bottom_sheet.dart';

class EditGroceryBottomSheet extends ConsumerStatefulWidget
    with ShowableBottomSheetMixin<Grocery> {
  const new({this.initialValue, super.key});

  final Grocery? initialValue;

  @override
  ConsumerState<EditGroceryBottomSheet> createState() =>
      _EditGroceryBottomSheetState();
}

class _EditGroceryBottomSheetState extends ConsumerState<EditGroceryBottomSheet>
    with HookMixin {
  late final searchController = useTextEditingController(
    text: widget.initialValue?.name,
  );

  @override
  void initState() {
    super.initState();

    searchController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final isEdition = widget.initialValue != null;

    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: false,
      builder: (context, scrollController) {
        return AppSheet(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: const Icon(Icons.edit_note),
                backgroundColor: Colors.transparent,
                title: Text(
                  isEdition ? strings.edit_grocery : strings.add_grocery,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: strings.close,
                    onPressed: context.pop,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const .all(16),
                  child: _InputField(
                    controller: searchController,
                    onSubmitted: (name) {
                      final appClock = ref.read(appClockProvider);
                      final grocery =
                          widget.initialValue?.copyWith(name: name) ??
                          Grocery(
                            id: const GroceryId(0),
                            name: name,
                            updatedAt: appClock.now(),
                          );
                      context.pop(grocery);
                    },
                  ),
                ),
              ),
              if (searchController.text.trim() case final query
                  when query.isNotEmpty)
                Consumer(
                  builder: (context, ref, _) {
                    final searchValue = ref.watch(
                      watchRecentSearchesProvider(query),
                    );

                    return searchValue.when(
                      skipLoadingOnRefresh: true,
                      data: (data) {
                        if (data.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        }

                        return SliverPadding(
                          padding: const .symmetric(horizontal: 16),
                          sliver: SliverList.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return _SuggestionTile(
                                item,
                                isEditing: widget.initialValue != null,
                              );
                            },
                          ),
                        );
                      },
                      error: (e, _) => SliverFillRemaining(
                        child: Center(child: Text('Error: $e')),
                      ),
                      loading: () => SliverFillRemaining(
                        child: Center(child: LoadingIndicator()),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _InputField extends ConsumerWidget {
  const new({required this.controller, required this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;

    return TextField(
      autofocus: controller.text.isEmpty,
      decoration: InputDecoration(
        hintText: strings.product_name,
        filled: true,
        fillColor: bottomSheetTheme.backgroundColor,
        border: OutlineInputBorder(borderRadius: .circular(20)),
      ),
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      onSubmitted: (value) {
        final name = value.trim();
        if (name.isEmpty) return context.pop();

        onSubmitted(name);
      },
    );
  }
}

class _SuggestionTile extends ConsumerStatefulWidget {
  const new(this.item, {required this.isEditing});

  final RecentSearch item;
  final bool isEditing;

  @override
  ConsumerState<_SuggestionTile> createState() => _SuggestionTileState();
}

class _SuggestionTileState extends ConsumerState<_SuggestionTile> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return ListTile(
      enabled: !added,
      leading: const TileIcon(Icons.history),
      title: Text(widget.item.query),
      trailing: !added ? const Icon(Icons.add) : Text(strings.added),
      onLongPress: () async {
        final action = await const RecentSearchActionsBottomSheet().show(
          context,
        );
        if (action == null || !context.mounted) return;

        switch (action) {
          case .delete:
            unawaited(
              ref
                  .read(homeLocalDatasourceProvider)
                  .deleteRecentSearch(widget.item.query),
            );
        }
      },
      onTap: added
          ? null
          : () {
              final grocery = Grocery(
                id: const GroceryId(0),
                name: widget.item.query,
                updatedAt: ref.read(appClockProvider).now(),
              );
              if (widget.isEditing) return context.pop(grocery);

              setState(() => added = true);
              unawaited(
                ref
                    .read(groceryListControllerProvider.notifier)
                    .createGrocery(grocery),
              );
            },
    );
  }
}
