import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/constants/consts.dart';
import 'package:fresh_list/src/core/localization/locale_controller.dart';
import 'package:fresh_list/src/core/theme/always_scrollbar_behavior.dart';
import 'package:fresh_list/src/core/theme/color_scheme_seed_controller.dart';
import 'package:fresh_list/src/core/theme/theme_controller.dart';
import 'package:fresh_list/src/router/router.dart';
import 'package:material_ui/material_ui.dart';

class App extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedIndex = ref.watch(colorSchemeSeedControllerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(localeControllerProvider),
      theme: ref.watch(lightThemeProvider(seedIndex)),
      darkTheme: ref.watch(darkThemeProvider(seedIndex)),
      themeMode: ref.watch(themeControllerProvider),
      scrollBehavior: const AlwaysScrollbarBehavior(),
      routerConfig: ref.watch(routerProvider(kDebugMode)),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: mediaQueryData.textScaler.clamp(maxScaleFactor: 1.1),
          ),
          child: child!,
        );
      },
    );
  }
}
