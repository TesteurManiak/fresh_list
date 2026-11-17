import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/widgets/app_sheet.dart';
import 'package:todo_list/src/core/widgets/sliver_spacing.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';

class NearbySharingBottomSheet extends ConsumerStatefulWidget
    with ShowableBottomSheetMixin<void> {
  const new({super.key});

  @override
  ConsumerState<NearbySharingBottomSheet> createState() =>
      _NearbySharingBottomSheetState();
}

class _NearbySharingBottomSheetState
    extends ConsumerState<NearbySharingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return AppSheet(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          const _SliverStatusTag(),
          const SliverSpacing(4),
          SliverToBoxAdapter(
            child: Text(
              // TODO(Guillaume): localize
              'Share Grocery List',
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: .w700,
                letterSpacing: -.5,
              ),
              textAlign: .center,
            ),
          ),
          const SliverSpacing(4),
          SliverToBoxAdapter(
            child: Text(
              // TODO(Guillaume): localize
              'Android Nearby Connections P2P Sync',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: .w400,
              ),
              textAlign: .center,
            ),
          ),
          const SliverSpacing(16),
          _SliverSharedListCard(),
          const SliverSpacing(16),
        ],
      ),
    );
  }
}

class _SliverStatusTag extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return SliverToBoxAdapter(
      child: UnconstrainedBox(
        child: Container(
          padding: const .symmetric(horizontal: 14, vertical: 2),
          decoration: ShapeDecoration(
            color: colorScheme.secondaryContainer,
            shape: const StadiumBorder(),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  alignment: .middle,
                  child: Padding(
                    padding: const .only(right: 6),
                    child: Icon(
                      Icons.sensors_rounded,
                      color: colorScheme.onSecondaryContainer,
                      size: 16,
                    ),
                  ),
                ),
                // TODO(Guillaume): localize
                const TextSpan(text: 'Nearby Share Active'),
              ],
            ),
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSecondaryContainer,
              fontWeight: .w600,
              letterSpacing: .2,
            ),
            textAlign: .center,
          ),
        ),
      ),
    );
  }
}

class _SliverSharedListCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(
      groceryListControllerProvider.select((l) => l.value?.length ?? 0),
    );

    return SliverToBoxAdapter(
      child: _Card(
        avatar: const _Avatar(child: Icon(Icons.shopping_cart_outlined)),
        // TODO(Guillaume): localize
        title: 'My list',
        // TODO(Guillaume): localize with pluralization
        subtitle: '$itemCount items',
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const new({
    required this.avatar,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final Widget avatar;
  final Widget? trailing;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Material(
      color: colorScheme.surfaceContainerLowest,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(24)),
      child: Padding(
        padding: const .all(16),
        child: Row(
          spacing: 8,
          children: [
            avatar,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: .w700,
                      letterSpacing: -.2,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  if (subtitle case final s?)
                    Text(
                      s,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: .w500,
                      ),
                    ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const new({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const dimension = 48.0;
    const contentSize = 20.0;
    final colorScheme = ColorScheme.of(context);

    return Container(
      height: dimension,
      width: dimension,
      alignment: .center,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        color: colorScheme.primaryContainer,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: contentSize,
          color: colorScheme.onPrimaryContainer,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: contentSize),
          child: child,
        ),
      ),
    );
  }
}
