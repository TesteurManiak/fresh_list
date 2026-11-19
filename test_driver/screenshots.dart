// DriverError is how waitFor reports a timeout.
// ignore_for_file: avoid_catching_errors

// Takes the README screenshots on a booted iOS simulator.
//
//   flutter drive \
//     --driver=test_driver/screenshots.dart \
//     --target=test_driver/app.dart \
//     -d <simulator id>
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

const _outputDir = 'docs/screenshots';
const _settle = Duration(milliseconds: 1000);

Future<void> main() async {
  final driver = await FlutterDriver.connect();
  // Fonts are precached before runApp, so the root widget can take a while to
  // attach, and driver commands fail until it does.
  for (var attempt = 0; ; attempt++) {
    try {
      await driver.runUnsynchronized(() async {});
      break;
    } on DriverError {
      if (attempt >= 60) rethrow;
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }

  // The app runs continuous animations, so frame sync would never settle.
  await driver.runUnsynchronized(() => _run(driver));
  await driver.close();
}

Future<void> _run(FlutterDriver driver) async {
  await Directory(_outputDir).create(recursive: true);

  Future<void> pause() => Future<void>.delayed(_settle);

  Future<void> tap(SerializableFinder finder) async {
    await driver.waitFor(finder);
    await driver.tap(finder);
    await pause();
  }

  Future<void> shot(String name) async {
    await pause();
    final result = await Process.run('xcrun', [
      'simctl',
      'io',
      'booted',
      'screenshot',
      '$_outputDir/$name.png',
    ]);
    if (result.exitCode != 0) {
      throw StateError('Screenshot failed: ${result.stderr}');
    }
  }

  final settings = find.byValueKey('settings_button');

  await shot('home');

  await tap(find.byType('FloatingActionButton'));
  await tap(find.byType('TextField'));
  await driver.enterText('Strawberries');
  await shot('add-entry');
  await driver.sendTextInputAction(TextInputAction.done);
  await shot('home-with-entry');

  await tap(settings);
  await shot('settings');

  await tap(find.byValueKey('theme_dark'));
  await shot('settings-dark');
}
