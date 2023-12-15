import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/core/extensions/string_extensions.dart';
import 'package:todo_list/src/core/mixins/showable.dart';

class AddGroceryBottomSheet extends StatefulWidget
    with ShowableBottomSheetMixin<String> {
  const AddGroceryBottomSheet({super.key});

  @override
  State<AddGroceryBottomSheet> createState() => _AddGroceryBottomSheetState();
}

class _AddGroceryBottomSheetState extends State<AddGroceryBottomSheet> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
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
    // TODO(Guillaume): find a better way to handle color transition (e.g. with the hue)
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      color: controller.text.isNotEmpty
          ? controller.text.toColor().withOpacity(0.2)
          : null,
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(hintText: 'Name'),
            onSubmitted: (value) => context.pop(value.trim()),
          ),
        ],
      ),
    );
  }
}
