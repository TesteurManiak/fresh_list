import 'dart:developer';

import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/mixins/hook.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/sharing/nearby_connections.dart';
import 'package:todo_list/src/core/widgets/app_sheet.dart';
import 'package:todo_list/src/core/widgets/sliver_spacing.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/home/widgets/copied_list_snack.dart';
import 'package:todo_list/src/features/home/widgets/error_snack.dart';
import 'package:todo_list/src/features/home/widgets/items_added_snack.dart';
import 'package:todo_list/src/features/home/widgets/list_sent_snack.dart';

class NearbySharingBottomSheet extends ConsumerStatefulWidget
    with ShowableBottomSheetMixin<void> {
  const new({super.key});

  @override
  ConsumerState<NearbySharingBottomSheet> createState() =>
      _NearbySharingBottomSheetState();
}

class _NearbySharingBottomSheetState
    extends ConsumerState<NearbySharingBottomSheet>
    with HookMixin {
  late final isStartingNotifier = useValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final controller = ref.read(nearbySharingControllerProvider.notifier);
    isStartingNotifier.value = true;
    try {
      await controller.stop();
      await controller.start();
    } catch (e, s) {
      log(
        'Error while starting nearby sharing',
        error: e,
        stackTrace: s,
        name: 'NearbySharingBottomSheet',
      );
      if (!mounted) return;
      ErrorSnack('$e').show(context);
    } finally {
      if (mounted) isStartingNotifier.value = false;
    }
  }

  Future<void> _onListReceived(ReceivedList received) async {
    ref.read(nearbySharingControllerProvider.notifier).clearReceivedList();

    final accepted = await _ReceivedListDialog(received).show(context);
    if (accepted != true || !mounted) return;

    final added = await ref
        .read(groceryListControllerProvider.notifier)
        .importGroceries(received.items);
    if (!mounted) return;
    ItemsAddedSnack(added).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final textTheme = TextTheme.of(context);
    final cs = ColorScheme.of(context);

    ref.listen(nearbySharingControllerProvider.select((s) => s.receivedList), (
      _,
      received,
    ) {
      if (received != null) _onListReceived(received);
    });

    return AppSheet(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              strings.nearby_share_grocery_list,
              style: textTheme.headlineMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: .w700,
                letterSpacing: -.5,
              ),
              textAlign: .center,
            ),
          ),
          const SliverSpacing(16),
          _SliverSharedListCard(),
          const SliverSpacing(16),
          ValueListenableBuilder(
            valueListenable: isStartingNotifier,
            builder: (_, isStarting, _) {
              return _SliverNearbyPeerList(isStarting: isStarting);
            },
          ),
          const SliverSpacing(16),
          SliverToBoxAdapter(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: textTheme.labelLarge?.copyWith(fontWeight: .w600),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(strings.dismiss),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverSharedListCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final itemCount = ref.watch(
      groceryListControllerProvider.select((l) => l.value?.length ?? 0),
    );

    return SliverToBoxAdapter(
      child: _Card(
        leading: const _Avatar(child: Icon(Icons.shopping_cart_outlined)),
        trailing: const Icon(Icons.copy_rounded),
        title: strings.nearby_my_list,
        subtitle: strings.nearby_item_count(itemCount),
        onTap: () => copyToClipboard(context, ref),
      ),
    );
  }

  Future<void> copyToClipboard(BuildContext context, WidgetRef ref) async {
    final items = await ref.read(groceryListControllerProvider.future);
    final buffer = StringBuffer();
    for (final item in items) {
      buffer.writeln('- ${item.name}');
    }
    await Clipboard.setData(ClipboardData(text: buffer.toString()));
    if (!context.mounted) return;
    const CopiedListSnack().show(context);
  }
}

class _Card extends StatelessWidget {
  const new({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == .light;
    final textTheme = TextTheme.of(context);
    final cs = ColorScheme.of(context);

    return Material(
      color: cs.surfaceContainer,
      clipBehavior: .antiAlias,
      elevation: isLight ? 1 : 0,
      shape: RoundedRectangleBorder(borderRadius: .circular(24)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const .all(16),
          child: Row(
            spacing: 8,
            children: [
              ?leading,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: cs.onSurface,
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
                          color: cs.onSurfaceVariant,
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
    final cs = ColorScheme.of(context);

    return Container(
      height: dimension,
      width: dimension,
      alignment: .center,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        color: cs.primaryContainer,
      ),
      child: IconTheme(
        data: IconThemeData(size: contentSize, color: cs.onPrimaryContainer),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: contentSize),
          child: child,
        ),
      ),
    );
  }
}

class _SliverNearbyPeerList extends ConsumerWidget {
  const new({required this.isStarting});

  final bool isStarting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final peers = ref.watch(
      nearbySharingControllerProvider.select((s) => s.peers),
    );

    return SliverMainAxisGroup(
      slivers: [
        _SliverNearbySharingHeader(),
        const SliverSpacing(4),
        if (isStarting || peers.isEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.25,
              child: isStarting
                  ? UnconstrainedBox(child: LoadingIndicator())
                  : const _SearchingIndicator(),
            ),
          )
        else
          SliverList.separated(
            itemCount: peers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemBuilder: (_, index) {
              final entry = peers.entries.elementAt(index);
              return _NearbyPeerTile(endpointId: entry.key, peer: entry.value);
            },
          ),
      ],
    );
  }
}

class _SearchingIndicator extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final cs = ColorScheme.of(context);

    return Column(
      mainAxisAlignment: .center,
      spacing: 16,
      children: [
        const _PulsingRadar(),
        Text(
          context.strings.nearby_searching,
          style: textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: .w500,
          ),
          textAlign: .center,
        ),
      ],
    );
  }
}

class _PulsingRadar extends StatefulWidget {
  const new();

  @override
  State<_PulsingRadar> createState() => _PulsingRadarState();
}

class _PulsingRadarState extends State<_PulsingRadar>
    with SingleTickerProviderStateMixin {
  static const _dimension = 96.0;
  static const _iconDimension = 48.0;
  static const _ringCount = 3;

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respect the system "reduce motion" setting.
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);

    return SizedBox.square(
      dimension: _dimension,
      child: Stack(
        alignment: .center,
        children: [
          // Staggered rings expanding from the icon and fading out.
          for (var i = 0; i < _ringCount; i++)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, _) {
                final t = (_controller.value + i / _ringCount) % 1;
                return Opacity(
                  opacity: 1 - t,
                  child: Container(
                    width: _iconDimension + (_dimension - _iconDimension) * t,
                    height: _iconDimension + (_dimension - _iconDimension) * t,
                    decoration: ShapeDecoration(
                      color: cs.primaryContainer.withValues(alpha: .5),
                      shape: const CircleBorder(),
                    ),
                  ),
                );
              },
            ),
          Container(
            width: _iconDimension,
            height: _iconDimension,
            decoration: ShapeDecoration(
              color: cs.primaryContainer,
              shape: const CircleBorder(),
            ),
            child: Icon(Icons.radar, color: cs.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

class _SliverNearbySharingHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final textTheme = TextTheme.of(context);
    final peersCount = ref.watch(
      nearbySharingControllerProvider.select((s) => s.peers.length),
    );
    return SliverToBoxAdapter(
      child: Padding(
        padding: const .symmetric(horizontal: 4),
        child: Text(
          strings.nearby_devices(peersCount),
          style: GoogleFonts.unbounded(
            textStyle: textTheme.labelSmall,
            letterSpacing: -.3,
            fontWeight: .w600,
          ),
        ),
      ),
    );
  }
}

class _NearbyPeerTile extends ConsumerWidget {
  const new({required this.endpointId, required this.peer});

  final String endpointId;
  final Peer peer;

  Future<void> _sendList(BuildContext context, WidgetRef ref) async {
    final Iterable<Grocery> groceries =
        ref.read(groceryListControllerProvider).value ?? const [];
    try {
      await ref
          .read(nearbySharingControllerProvider.notifier)
          .sendList(endpointId, groceries);
      if (!context.mounted) return;
      ListSentSnack(peer.name).show(context);
    } catch (e, s) {
      log(
        'Error while sending list',
        error: e,
        stackTrace: s,
        name: 'NearbySharingBottomSheet',
      );
      if (!context.mounted) return;
      ErrorSnack('$e').show(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final cs = ColorScheme.of(context);

    return _Card(
      leading: _Avatar(child: Text(peer.name[0])),
      title: peer.name,
      subtitle: peer.state == .connected ? strings.nearby_connected : null,
      trailing: switch (peer.state) {
        .found => Icon(
          Icons.link_rounded,
          color: cs.onSurfaceVariant,
          semanticLabel: strings.nearby_connect,
        ),
        .connecting => SizedBox.square(
          dimension: 24,
          child: LoadingIndicator(semanticsLabel: strings.nearby_connecting),
        ),
        .connected => Icon(
          Icons.send_rounded,
          color: cs.primary,
          semanticLabel: strings.nearby_send_list,
        ),
      },
      onTap: switch (peer.state) {
        .found =>
          () => ref
              .read(nearbySharingControllerProvider.notifier)
              .requestConnection(endpointId),
        .connecting => null,
        .connected => () => _sendList(context, ref),
      },
    );
  }
}

class _ReceivedListDialog extends StatelessWidget
    with ShowableDialogMixin<bool> {
  const new(this.received);

  final ReceivedList received;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final count = received.items.length;

    return AlertDialog(
      title: Text(strings.nearby_list_received_title(received.from)),
      content: Text(strings.nearby_list_received_message(count)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(count == 0 ? strings.close : strings.cancel),
        ),
        if (count > 0)
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.nearby_add),
          ),
      ],
    );
  }
}
