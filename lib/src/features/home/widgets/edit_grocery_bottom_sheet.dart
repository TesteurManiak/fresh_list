import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/features/home/data/models/grocery.dart';

class EditGroceryBottomSheet extends StatefulWidget
    with ShowableBottomSheetMixin<Grocery> {
  const EditGroceryBottomSheet({
    this.initialValue,
    super.key,
  });

  final Grocery? initialValue;

  @override
  State<EditGroceryBottomSheet> createState() => _EditGroceryBottomSheetState();
}

class _EditGroceryBottomSheetState extends State<EditGroceryBottomSheet> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller
      ..text = widget.initialValue?.name ?? ''
      ..addListener(() {
        final cleanedText = controller.text.trim();
        if (cleanedText.isNotEmpty) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(hintText: 'Name'),
            onSubmitted: (value) {
              final name = value.trim();
              final grocery = widget.initialValue?.copyWith(name: name) ??
                  Grocery(name: name, order: 0);
              context.pop(grocery);
            },
          ),
        ],
      ),
    );
  }
}
