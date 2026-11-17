import 'dart:async';
import 'dart:developer';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native_nearby_connections/native_nearby_connections.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/permissions/permission_manager.dart';
import 'package:todo_list/src/core/sharing/shared_grocery_list.dart';
import 'package:todo_list/src/core/utils/device_info.dart';

part 'nearby_connections.freezed.dart';

const _kServiceId = 'com.example.todo_list';

final nearbyConnectionsProvider = Provider((_) => NativeNearbyConnections());

final nearbySharingControllerProvider =
    NotifierProvider.autoDispose<NearbySharingController, NearbySharingState>(
      NearbySharingController.new,
    );

/// Name other devices see for this one.
final deviceNameProvider = FutureProvider<String>((ref) {
  final deviceInfoService = ref.watch(deviceInfoServiceProvider);
  return deviceInfoService.getDeviceName();
});

class NearbySharingController extends Notifier<NearbySharingState>
    implements NearbyFlutterApi {
  @override
  NearbySharingState build() {
    final nearby = ref.watch(nearbyConnectionsProvider)..setListener(this);

    ref.onDispose(() => _dispose(nearby));

    return const NearbySharingState();
  }

  void _dispose(NativeNearbyConnections nearby) {
    nearby
      ..setListener(null)
      ..stopAdvertising()
      ..stopDiscovery()
      ..stopAllEndpoints();
  }

  /// Advertises and discovers at once, so both devices see each other.
  Future<void> start() async {
    state = state.copyWith(isAdvertising: true, isDiscovering: true);
    try {
      await ref
          .read(permissionManagerProvider)
          .requestNearbySharingPermission();
      final deviceName = await ref.read(deviceNameProvider.future);
      final nearby = ref.read(nearbyConnectionsProvider);

      await Future.wait([
        nearby.startAdvertising(deviceName, _kServiceId, .cluster),
        nearby.startDiscovery(_kServiceId, .cluster),
      ], eagerError: true);
    } catch (e, s) {
      log(
        'Error while starting nearby sharing',
        error: e,
        stackTrace: s,
        name: 'NearbySharingController',
      );
      await stop();
      rethrow;
    }
  }

  Future<void> stop() async {
    // No early return on idle state: after a hot restart the native session
    // may still be running while this state says idle.
    await Future.wait([
      ref.read(nearbyConnectionsProvider).stopAdvertising(),
      ref.read(nearbyConnectionsProvider).stopDiscovery(),
      ref.read(nearbyConnectionsProvider).stopAllEndpoints(),
    ]);

    state = state.copyWith(
      isAdvertising: false,
      isDiscovering: false,
      peers: state.peers.clear(),
    );
  }

  Future<void> requestConnection(String endpointId) async {
    final peer = state.peers[endpointId];
    if (peer == null || peer.state != .found) return;

    _setPeerState(endpointId, .connecting);
    try {
      final deviceName = await ref.read(deviceNameProvider.future);
      await ref
          .read(nearbyConnectionsProvider)
          .requestConnection(deviceName, endpointId);
      // `connected` is set by onConnectionResult.
    } catch (e, s) {
      log(
        'Error while requesting connection',
        error: e,
        stackTrace: s,
        name: 'NearbySharingController',
      );
      // Back to found so it can be retried.
      _setPeerState(endpointId, .found);
    }
  }

  void _setPeerState(String endpointId, PeerState peerState) {
    if (!state.peers.containsKey(endpointId)) return;
    state = state.copyWith(
      peers: state.peers.update(
        endpointId,
        (val) => val.copyWith(state: peerState),
      ),
    );
  }

  Future<void> sendList(String endpointId, Iterable<Grocery> groceries) {
    return ref.read(nearbyConnectionsProvider).sendBytes([
      endpointId,
    ], SharedGroceryListCodec.encode(groceries));
  }

  /// Call once the received list has been handled.
  void clearReceivedList() {
    state = state.copyWith(receivedList: null);
  }

  @override
  void onConnectionInitiated(String endpointId, ConnectionInfo info) {
    final peer = Peer(
      name: info.endpointName ?? endpointId,
      state: .connecting,
    );

    state = state.copyWith(
      peers: state.peers.update(
        endpointId,
        (val) => peer,
        ifAbsent: () => peer,
      ),
    );
    ref.read(nearbyConnectionsProvider).acceptConnection(endpointId);
  }

  @override
  void onConnectionResult(String endpointId, int statusCode) {
    final peer = state.peers[endpointId];
    if (peer == null) return;

    if (statusCode != 0) {
      // Keep the peer to retry while discovering; otherwise wait for a new
      // request.
      state = state.isDiscovering
          ? state.copyWith(
              peers: state.peers.update(
                endpointId,
                (val) => val.copyWith(state: .found),
              ),
            )
          : state.copyWith(peers: state.peers.remove(endpointId));
      return;
    }

    state = state.copyWith(
      peers: state.peers.update(
        endpointId,
        (val) => val.copyWith(state: .connected),
      ),
    );

    // Scanning slows transfers and both radios drain battery: stop looking
    // once paired. Searching resumes when the last peer disconnects.
    final nearby = ref.read(nearbyConnectionsProvider);
    unawaited(nearby.stopDiscovery());
    unawaited(nearby.stopAdvertising());
    state = state.copyWith(isAdvertising: false, isDiscovering: false);
  }

  @override
  void onDisconnected(String endpointId) {
    state = state.copyWith(peers: state.peers.remove(endpointId));
    // start() already logs its errors.
    if (state.peers.isEmpty) start().ignore();
  }

  @override
  void onEndpointFound(EndpointInfo info) {
    final id = info.endpointId;

    // Ignore if the endpoint ID is null or the peer is already known.
    if (id == null || state.peers.containsKey(id)) return;

    state = state.copyWith(
      peers: state.peers.add(id, Peer(name: info.name ?? id, state: .found)),
    );
    // Pairing is manual: the user taps the peer to call requestConnection.
  }

  @override
  void onEndpointLost(String endpointId) {
    final peer = state.peers[endpointId];
    // Losing discovery of a peer we're connected or connecting to is harmless.
    if (peer == null || peer.state != .found) return;
    state = state.copyWith(peers: state.peers.remove(endpointId));
  }

  @override
  void onPayloadReceived(String endpointId, PayloadMessage payload) {
    // Only bytes payloads carry a list; files and streams are not sent.
    final bytes = payload.bytes;
    if (bytes == null) return;

    try {
      state = state.copyWith(
        receivedList: (
          from: state.peers[endpointId]?.name ?? endpointId,
          items: SharedGroceryListCodec.decode(bytes),
        ),
      );
    } on FormatException catch (e, s) {
      log(
        'Ignored invalid payload from $endpointId',
        error: e,
        stackTrace: s,
        name: 'NearbySharingController',
      );
    }
  }

  @override
  void onPayloadTransferUpdate(String endpointId, TransferUpdate update) {}
}

@freezed
sealed class NearbySharingState with _$NearbySharingState {
  const factory({
    @Default(false) bool isAdvertising,
    @Default(false) bool isDiscovering,
    @Default(IMap<String, Peer>.empty()) IMap<String, Peer> peers,

    /// Last list received from a peer, waiting for the user to accept it.
    ReceivedList? receivedList,
  }) = _NearbySharingState;
}

typedef ReceivedList = ({String from, List<SharedGrocery> items});

enum PeerState { found, connecting, connected }

@freezed
abstract class Peer with _$Peer {
  const factory({required String name, required PeerState state}) = _Peer;
}
