import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/formatters/quantity_formatter.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/widgets/dismissible.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';

const _kAnimationDuration = Duration(milliseconds: 300);

class GroceryTile extends ConsumerWidget {
  const new(this.grocery, {required Key super.key});

  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = BorderRadius.all(.circular(16));

    final colorScheme = ColorScheme.of(context);

    return AnimatedContainer(
      duration: _kAnimationDuration,
      margin: const .symmetric(vertical: 4),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          if (!grocery.completed)
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: AppDismissible(
        key: Key('GroceryTile-${grocery.id}'),
        direction: DismissDirection.endToStart,
        movementDuration: _kAnimationDuration,
        onDismissed: (direction) {
          if (direction == .endToStart) {
            unawaited(
              ref
                  .read(groceryListControllerProvider.notifier)
                  .deleteGrocery(grocery),
            );
          }
        },
        background: const _Background(borderRadius: borderRadius),
        child: _GroceryCard(borderRadius: borderRadius, grocery: grocery),
      ),
    );
  }
}

class _GroceryCard extends ConsumerWidget {
  const new({required this.borderRadius, required this.grocery});

  final BorderRadius borderRadius;
  final Grocery grocery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tileBorderRadius = BorderRadius.all(.circular(12));
    final colorScheme = ColorScheme.of(context);

    return AnimatedContainer(
      duration: _kAnimationDuration,
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: tileBorderRadius,
        color: grocery.completed
            ? const Color(0xFFFCF1EF)
            : colorScheme.onPrimaryContainer,
      ),
      child: Material(
        type: .transparency,
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: () => _showEditionBottomSheet(context, ref, grocery),
          borderRadius: borderRadius,
          child: Padding(
            padding: const .all(12),
            child: Row(
              children: [
                Checkbox(
                  value: grocery.completed,
                  onChanged: (_) => ref
                      .read(groceryListControllerProvider.notifier)
                      .toggle(grocery),
                ),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: _kAnimationDuration,
                    style: TextStyle(
                      decoration: grocery.completed ? .lineThrough : null,
                      color: grocery.completed
                          ? const Color(0xFF57423B)
                          : const Color(0xFF1F1B1A),
                      fontWeight: .w600,
                      fontSize: 16,
                      height: 20 / 16,
                    ),

                    child: Text(grocery.name),
                  ),
                ),
                if (grocery.quantity case final q? when q > 0)
                  _QuantityChip(grocery),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditionBottomSheet(
    BuildContext context,
    WidgetRef ref,
    Grocery initialValue,
  ) async {
    final grocery = await EditGroceryBottomSheet(initialValue: initialValue)
        .show(context);
    if (grocery == null || grocery == this.grocery || !context.mounted) return;

    unawaited(
      ref.read(groceryListControllerProvider.notifier).updateGrocery(grocery),
    );
  }
}

class const _QuantityChip(final Grocery grocery) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantityFormatter = ref.watch(quantityFormatterProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E6E4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        grocery.formatQuantity(quantityFormatter),
        style: const TextStyle(
          color: Color(0xFF57423B),
          fontWeight: FontWeight.bold,
          fontSize: 12,
          height: 16 / 12,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const new({required this.borderRadius});

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    const onBackgroundColor = Color(0xFFFFFBFF);

    final strings = AppLocalizations.of(context);

    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: const Color(0xFFBF542C),
      ),
      padding: const .symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .end,
        children: [
          const Icon(Icons.delete, color: onBackgroundColor),
          Text(
            strings.quick_action_delete,
            style: const TextStyle(
              color: onBackgroundColor,
              fontWeight: .w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
