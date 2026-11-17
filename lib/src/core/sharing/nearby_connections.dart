import 'dart:developer';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native_nearby_connections/native_nearby_connections.dart';
import 'package:todo_list/src/core/models/grocery.dart';
import 'package:todo_list/src/core/permissions/permission_manager.dart';
import 'package:todo_list/src/core/sharing/shared_grocery_list.dart';

part 'nearby_connections.freezed.dart';

const _kServiceId = 'com.example.todo_list';

final nearbyConnectionsProvider = Provider((_) => NativeNearbyConnections());

final nearbySharingControllerProvider =
    NotifierProvider.autoDispose<NearbySharingController, NearbySharingState>(
      () => NearbySharingController('My Device'),
    );

class NearbySharingController extends Notifier<NearbySharingState>
    implements NearbyFlutterApi {
  new(this.localEndpointName);

  final String localEndpointName;

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

  Future<void> advertise() async {
    state = state.copyWith(isAdvertising: true);
    try {
      await _requestPermission();
      await ref
          .read(nearbyConnectionsProvider)
          .startAdvertising(localEndpointName, _kServiceId, .cluster);
    } catch (e, s) {
      log(
        'Error while advertising',
        error: e,
        stackTrace: s,
        name: 'NearbySharingController',
      );
      state = state.copyWith(isAdvertising: false);
      rethrow;
    }
  }

  Future<void> discover() async {
    state = state.copyWith(isDiscovering: true);
    try {
      await _requestPermission();
      await ref
          .read(nearbyConnectionsProvider)
          .startDiscovery(_kServiceId, .cluster);
    } catch (e, s) {
      log(
        'Error while discovering',
        error: e,
        stackTrace: s,
        name: 'NearbySharingController',
      );
      state = state.copyWith(isDiscovering: false);
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

  Future<void> _requestPermission() =>
      ref.read(permissionManagerProvider).requestNearbySharingPermission();

  Future<void> requestConnection(String endpointId) async {
    final peer = state.peers[endpointId];
    if (peer == null || peer.state != .found) return;

    _setPeerState(endpointId, .connecting);
    try {
      await ref
          .read(nearbyConnectionsProvider)
          .requestConnection(localEndpointName, endpointId);
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
      // Discoverer keeps the peer to retry; advertiser waits for a new request.
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

    if (!state.isDiscovering) return;

    // Scanning slows transfers; tap Discover again to find more peers.
    ref.read(nearbyConnectionsProvider).stopDiscovery();
    state = state.copyWith(isDiscovering: false);
  }

  @override
  void onDisconnected(String endpointId) {
    state = state.copyWith(peers: state.peers.remove(endpointId));
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
