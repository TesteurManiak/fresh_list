import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/features/home/data/repositories/home_repository.dart';

class EditGroceryBottomSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<Grocery> {
  const EditGroceryBottomSheet({this.initialValue, super.key});

  final Grocery? initialValue;

  @override
  bool get isScrollControlled => true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final isEdition = initialValue != null;

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
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: strings.close,
                  onPressed: context.pop,
                ),
                title: Text(
                  isEdition ? strings.edit_grocery : strings.add_grocery,
                ),
                actions: const [],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _InputField(initialValue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InputField extends ConsumerStatefulWidget {
  const _InputField(this.initialValue);

  final Grocery? initialValue;

  @override
  ConsumerState<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<_InputField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue?.name ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: widget.initialValue?.name ?? ''),
      optionsBuilder: (textEditingValue) async {
        final query = textEditingValue.text.trim();
        if (query.isEmpty) return [];

        return ref.read(homeRepositoryProvider).getRecentSearches(query);
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          autofocus: widget.initialValue == null,
          decoration: InputDecoration(hintText: strings.product_name),
          controller: controller,
          focusNode: focusNode,
          onSubmitted: (value) {
            onFieldSubmitted();

            final name = value.trim();
            if (name.isEmpty) {
              context.pop();
              return;
            }

            final grocery =
                widget.initialValue?.copyWith(name: name) ??
                Grocery(id: 0, name: name, order: 0, completed: false);
            context.pop(grocery);
          },
        );
      },
    );
  }
}
