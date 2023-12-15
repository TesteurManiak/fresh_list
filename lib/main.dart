import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/src/core/locale/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';

Future<void> main() async {
  final container = ProviderContainer();

  await Future.wait(
    [
      container.read(localeControllerProvider.notifier).init(),
      container.read(themeControllerProvider.notifier).init(),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
