import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/gen/assets.gen.dart';
import 'package:fresh_list/src/core/models/grocery.dart';
import 'package:fresh_list/src/core/utils/haptics_helper.dart';
import 'package:fresh_list/src/core/widgets/checkbox.dart';
import 'package:fresh_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:fresh_list/src/features/home/widgets/edit_grocery_bottom_sheet.dart';
import 'package:fresh_list/src/features/home/widgets/edited_snack.dart';
import 'package:fresh_list/src/features/home/widgets/grocery_card.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart';

class GroceryTile extends ConsumerStatefulWidget {
  const new(
    this.grocery, {
    required Key super.key,
    required this.borderRadius,
    this.dismissThreshold = 0.4,
  });

  final Grocery grocery;
  final double dismissThreshold;
  final BorderRadius borderRadius;

  static const outerRadius = 16.0;
  static const innerRadius = 2.0;
  static const tileGap = 2.0;

  static BorderRadius radiusFor(int index, int length, bool selected) {
    const Radius outer = Radius.circular(outerRadius);
    const Radius inner = Radius.circular(innerRadius);

    return .vertical(
      top: (index == 0 || selected) ? outer : inner,
      bottom: (index == length - 1 || selected) ? outer : inner,
    );
  }

  @override
  ConsumerState<GroceryTile> createState() => _GroceryTileState();
}

class _GroceryTileState extends ConsumerState<GroceryTile> {
  double dragProgress = 0;
  bool hasTriggeredHaptic = false;

  @override
  Widget build(BuildContext context) {
    final grocery = widget.grocery;
    final isThresholdReached = dragProgress >= widget.dismissThreshold;

    return Padding(
      padding: const .symmetric(vertical: GroceryTile.tileGap),
      child: Dismissible(
        key: Key('GroceryTile-${grocery.id}'),
        direction: .endToStart,
        dismissThresholds: {.endToStart: widget.dismissThreshold},
        onUpdate: (details) {
          setState(() => dragProgress = details.progress);

          if (details.progress >= widget.dismissThreshold &&
              !hasTriggeredHaptic) {
            HapticFeedback.lightImpact();
            hasTriggeredHaptic = true;
          } else if (details.progress < widget.dismissThreshold &&
              hasTriggeredHaptic) {
            hasTriggeredHaptic = false;
          }
        },
        onDismissed: (_) => ref
            .read(groceryListControllerProvider.notifier)
            .deleteGrocery(grocery),
        background: _Background(
          isThresholdReached: isThresholdReached,
          dragProgress: dragProgress,
        ),
        child: _Card(grocery: grocery, borderRadius: widget.borderRadius),
      ),
    );
  }
}

class _Card extends ConsumerWidget {
  const new({required this.grocery, required this.borderRadius});

  final Grocery grocery;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GroceryCard(
      name: grocery.name,
      completed: grocery.completed,
      borderRadius: borderRadius,
      onTap: () {
        HapticsHelper.light();
        _showEditionBottomSheet(context, ref, grocery);
      },
      leading: AppCheckbox(
        value: grocery.completed,
        size: 24,
        onChanged: (_) {
          grocery.completed ? HapticsHelper.light() : HapticsHelper.success();
          ref.read(groceryListControllerProvider.notifier).toggle(grocery);
        },
      ),
      trailing: AnimatedScale(
        duration: GroceryCard.animationDuration,
        curve: GroceryCard.animationCurve,
        scale: grocery.completed ? 1.0 : 0.0,
        child: const Icon(Icons.done_all),
      ),
    );
  }

  Future<void> _showEditionBottomSheet(
    BuildContext context,
    WidgetRef ref,
    Grocery initialValue,
  ) async {
    final edited = await EditGroceryBottomSheet(initialValue: initialValue)
        .show(context);
    if (edited == null || edited == grocery || !context.mounted) return;

    EditedSnack(edited.name).show(context);
    unawaited(
      ref.read(groceryListControllerProvider.notifier).updateGrocery(edited),
    );
  }
}

class _Background extends StatelessWidget {
  const new({required this.isThresholdReached, required this.dragProgress});

  final bool isThresholdReached;
  final double dragProgress;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return Container(
      alignment: .centerRight,
      color: cs.surface,
      child: FractionallySizedBox(
        widthFactor: dragProgress.clamp(0.0, 1.0),
        heightFactor: 1,
        alignment: .centerRight,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: cs.error,
              shape: const StadiumBorder(),
            ),
            child: Center(
              child: _DeleteIcon(isThresholdReached: isThresholdReached),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteIcon extends StatefulWidget {
  const new({required this.isThresholdReached});

  final bool isThresholdReached;

  @override
  State<_DeleteIcon> createState() => _DeleteIconState();
}

class _DeleteIconState extends State<_DeleteIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void didUpdateWidget(covariant _DeleteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isThresholdReached) controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return AppAssets.lottieTrash.lottie(
      height: 28,
      controller: controller,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(['**'], value: cs.onError),
        ],
      ),
    );
  }
}
