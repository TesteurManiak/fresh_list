import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/core/mixins/showable.dart';

class AddGroceryBottomSheet extends StatelessWidget
    with ShowableBottomSheetMixin<String> {
  const AddGroceryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            onSubmitted: (value) => context.pop(value),
          ),
        ],
      ),
    );
  }
}
