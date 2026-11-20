import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/exceptions/unsupported_platform_error.dart';

final deviceInfoPluginProvider = Provider((_) => DeviceInfoPlugin());

final deviceInfoServiceProvider = Provider((ref) {
  final deviceInfoPlugin = ref.watch(deviceInfoPluginProvider);
  return DeviceInfoService(deviceInfoPlugin: deviceInfoPlugin);
});

/// Name other devices see for this one.
final deviceNameProvider = FutureProvider<String>((ref) {
  final deviceInfoService = ref.watch(deviceInfoServiceProvider);
  return deviceInfoService.getDeviceName();
});

class const DeviceInfoService({
  required final DeviceInfoPlugin deviceInfoPlugin,
}) {
  Future<int> getAndroidSdkInt() async {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<String> getDeviceName() async {
    switch (Platform.operatingSystem) {
      case 'android':
        final info = await deviceInfoPlugin.androidInfo;
        return info.name.isNotEmpty ? info.name : info.model;
      case 'ios':
        final info = await deviceInfoPlugin.iosInfo;
        // Without Apple's user-assigned-device-name entitlement, iOS 16+ only
        // returns the generic model ("iPhone"): the model name tells devices
        // apart better.
        return info.name != info.model ? info.name : info.modelName;
      case final platform:
        throw UnsupportedPlatformError(platform);
    }
  }
}
