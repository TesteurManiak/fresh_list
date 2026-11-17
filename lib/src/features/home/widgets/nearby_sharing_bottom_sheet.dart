import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_wavy_progress_indicator/material_wavy_progress_indicator.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/extensions/build_context_extensions.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/mixins/hook.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/sharing/nearby_connections.dart';
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
    extends ConsumerState<NearbySharingBottomSheet>
    with HookMixin {
  late final selectedModeNotifier = useValueNotifier(_DiscoveryMode.advertise);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
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
              strings.nearby_share_grocery_list,
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface,
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
            valueListenable: selectedModeNotifier,
            builder: (_, selectedMode, _) {
              return _SliverDiscoveryModeSelector(
                selectedMode: selectedMode,
                onSelectionChanged: (v) => selectedModeNotifier.value = v,
              );
            },
          ),
          const SliverSpacing(16),
          _SliverNearbyPeerList(),
          const SliverSpacing(16),
          SliverToBoxAdapter(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: textTheme.labelLarge?.copyWith(fontWeight: .w600),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Dismiss'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverStatusTag extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
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
                TextSpan(text: strings.nearby_share_active),
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
    final strings = context.strings;
    final itemCount = ref.watch(
      groceryListControllerProvider.select((l) => l.value?.length ?? 0),
    );

    return SliverToBoxAdapter(
      child: _Card(
        leading: const _Avatar(child: Icon(Icons.shopping_cart_outlined)),
        title: strings.nearby_my_list,
        subtitle: strings.nearby_item_count(itemCount),
      ),
    );
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
    final colorScheme = ColorScheme.of(context);

    return Material(
      color: colorScheme.surfaceContainer,
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

class _SliverDiscoveryModeSelector extends StatelessWidget {
  const new({required this.selectedMode, required this.onSelectionChanged});

  final _DiscoveryMode selectedMode;
  final ValueChanged<_DiscoveryMode> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SliverToBoxAdapter(
      child: SegmentedButton<_DiscoveryMode>(
        selected: {selectedMode},
        onSelectionChanged: (value) => onSelectionChanged(value.first),
        segments: [
          for (final mode in _DiscoveryMode.values)
            ButtonSegment(
              value: mode,
              label: Text(mode.label(strings)),
              icon: Icon(mode.icon),
            ),
        ],
      ),
    );
  }
}

enum _DiscoveryMode(final LocalizedString label, final IconData icon) {
  advertise(_advertise, Icons.radar),
  discover(_discover, Icons.wifi_tethering);

  static String _advertise(AppLocalizations strings) =>
      strings.nearby_advertise;

  static String _discover(AppLocalizations strings) => strings.nearby_discover;
}

class _SliverNearbyPeerList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final peers = ref.watch(
      nearbySharingControllerProvider.select((s) => s.peers),
    );
    final showLoading = ref.watch(
      nearbySharingControllerProvider.select((s) => s.showLoading),
    );

    return SliverMainAxisGroup(
      slivers: [
        _SliverNearbySharingHeader(),
        const SliverSpacing(4),
        if (showLoading)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.25,
              child: const UnconstrainedBox(
                child: CircularWavyProgressIndicator(),
              ),
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

class _NearbyPeerTile extends StatelessWidget {
  const new({required this.endpointId, required this.peer});

  final String endpointId;
  final Peer peer;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    return _Card(
      leading: _Avatar(child: Text(peer.name[0])),
      title: peer.name,
      trailing: FilledButton(
        onPressed: () {
          // TODO(Guillaume): Implement
        },
        child: Text(strings.nearby_connect),
      ),
    );
  }
}

extension on NearbySharingState {
  bool get showLoading => isAdvertising || isDiscovering || peers.isEmpty;
}
