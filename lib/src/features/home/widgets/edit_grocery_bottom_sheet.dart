import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/hook.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';

class EditGroceryBottomSheet extends ConsumerStatefulWidget
    with ShowableBottomSheetMixin<Grocery> {
  const new({this.initialValue, super.key});

  final Grocery? initialValue;

  @override
  bool get isScrollControlled => true;

  @override
  bool get showDragHandle => true;

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
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: const Icon(Icons.edit_note),
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
                      final grocery =
                          widget.initialValue?.copyWith(name: name) ??
                          Grocery(
                            id: 0,
                            name: name,
                            order: 0,
                            completed: false,
                          );
                      context.pop(grocery);
                    },
                  ),
                ),
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

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controller.text),
      optionsBuilder: (textEditingValue) async {
        final query = textEditingValue.text.trim();
        if (query.isEmpty) return [];

        final results = await ref.read(
          watchRecentSearchesProvider(query).future,
        );
        return results.map((e) => e.query).toList();
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          autofocus: controller.text.isEmpty,
          decoration: InputDecoration(
            hintText: strings.product_name,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: .circular(12)),
          ),
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          focusNode: focusNode,
          onSubmitted: (value) {
            onFieldSubmitted();

            final name = value.trim();
            if (name.isEmpty) return context.pop();

            onSubmitted(name);
          },
        );
      },
    );
  }
}
