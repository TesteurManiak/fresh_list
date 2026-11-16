import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_nearby_connections/native_nearby_connections.dart';

final nearbyConnectionsProvider = Provider((_) => NativeNearbyConnections());
