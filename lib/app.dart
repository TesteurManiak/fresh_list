import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/consts.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';
import 'package:todo_list/src/router/router.dart';

class App extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: Consts.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(localeControllerProvider),
      theme: ref.watch(lightThemeProvider),
      themeMode: ref.watch(themeControllerProvider),
      routerConfig: ref.watch(routerProvider(kDebugMode)),
    );
  }
}
