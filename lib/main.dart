import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  final container = ProviderContainer();
  await Future.wait([
    container.read(localeControllerProvider.notifier).init(),
    container.read(themeControllerProvider.notifier).init(),
  ]);

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
