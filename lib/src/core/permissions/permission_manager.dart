import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManagerProvider = Provider((_) => const PermissionManager());

class const PermissionManager() {
  Future<void> _requestPermission(List<Permission> permissions) async {
    final statuses = await permissions.request();
    final denied = <Permission, PermissionStatus>{
      for (final entry in statuses.entries)
        if (entry.value.isDenied) entry.key: entry.value,
    };
    if (denied.isEmpty) return;

    throw PermissionDeniedException(
      denied.entries.map((e) => '${e.key}: ${e.value}').toList(),
    );
  }

  Future<void> requestNearbySharingPermission() {
    return switch (Platform.operatingSystem) {
      'android' => _requestPermission([
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
        Permission.nearbyWifiDevices,

        /// Location is only declared up to Android 12.
        // Permission.location,
      ]),
      // Local network prompts by itself on first Bonjour use; location lets
      // Nearby join a peer's Wi-Fi hotspot.
      'ios' => _requestPermission([
        Permission.bluetooth,
        Permission.locationWhenInUse,
      ]),
      final platform => throw UnsupportedError(
        'Unsupported platform: $platform',
      ),
    };
  }
}

class const PermissionDeniedException(final List<String> deniedPermissions)
    implements Exception {
  @override
  String toString() =>
      'PermissionDeniedException: ${deniedPermissions.join(', ')}';
}
