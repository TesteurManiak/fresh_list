import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/exceptions/unsupported_platform_error.dart';
import 'package:fresh_list/src/core/utils/device_info.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManagerProvider = Provider(
  (ref) => PermissionManager(
    deviceInfoService: ref.watch(deviceInfoServiceProvider),
  ),
);

class const PermissionManager({
  required final DeviceInfoService deviceInfoService,
}) {
  Future<void> requestNearbySharingPermission() {
    return switch (Platform.operatingSystem) {
      'android' => _requestAndroidNearbySharingPermission(),
      'ios' => _requestIosNearbySharingPermission(),
      final platform => throw UnsupportedPlatformError(platform),
    };
  }

  /// Matches the Nearby Connections manifest:
  /// https://developers.google.com/nearby/connections/android/get-started
  Future<void> _requestAndroidNearbySharingPermission() async {
    final sdkInt = await deviceInfoService.getAndroidSdkInt();
    await [
      // Reported granted by permission_handler below Android 12 (API 31)
      // and, for nearbyWifiDevices, below Android 13 (API 33).
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.nearbyWifiDevices,
      // Scanning needs location up to Android 12L (API 32); from 13 the
      // permissions above are declared neverForLocation and location isn't
      // declared at all.
      if (sdkInt <= 32) Permission.location,
    ].request();
  }

  /// Local network prompts by itself on first Bonjour use; location lets
  /// Nearby join a peer's Wi-Fi hotspot.
  Future<void> _requestIosNearbySharingPermission() async {
    await [Permission.bluetooth, Permission.locationWhenInUse].request();
  }
}

class const PermissionDeniedException(final List<String> deniedPermissions)
    implements Exception {
  @override
  String toString() =>
      'PermissionDeniedException: ${deniedPermissions.join(', ')}';
}
