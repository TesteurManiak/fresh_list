import 'package:flutter_driver/driver_extension.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/main.dart' as app;
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';

Future<void> main() async {
  enableFlutterDriverExtension();
  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(
    overrides: [
      localeControllerProvider.overrideWith(_EnglishLocaleController.new),
      themeControllerProvider.overrideWith(_LightThemeController.new),
    ],
  );
}

// Ignore the device settings and stored preferences so screenshots are stable.
class _EnglishLocaleController extends LocaleController {
  @override
  Locale build() => const Locale('en', 'US');

  @override
  Future<void> init() async {}

  @override
  Future<void> setLocale(Locale locale) async => state = locale;
}

class _LightThemeController extends ThemeController {
  @override
  ThemeMode build() => ThemeMode.light;

  @override
  Future<void> init() async {}

  @override
  Future<void> setThemeMode(ThemeMode mode) async => state = mode;
}
