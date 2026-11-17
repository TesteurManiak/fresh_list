import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManagerProvider = Provider((_) => const PermissionManager());

class const PermissionManager() {
  Future<bool> _requestPermission(List<Permission> permissions) {
    return permissions.request().then(
      (statuses) => statuses.values.every((status) => status.isGranted),
    );
  }

  Future<bool> requestNearbySharingPermission() {
    return switch (Platform.operatingSystem) {
      'android' => _requestPermission([
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
        Permission.nearbyWifiDevices,

        /// Location is only declared up to Android 12.
        // Permission.location,
      ]),
      'ios' => _requestPermission([Permission.bluetooth]),
      final platform => throw UnsupportedError(
        'Unsupported platform: $platform',
      ),
    };
  }
}
