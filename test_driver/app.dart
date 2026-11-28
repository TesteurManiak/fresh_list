import 'package:dynamic_color_ffi/dynamic_color_ffi.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:fresh_list/main.dart' as app;
import 'package:fresh_list/src/core/localization/locale_notifier.dart';
import 'package:fresh_list/src/core/models/recent_search.dart';
import 'package:fresh_list/src/core/theme/dynamic_color_notifier.dart';
import 'package:fresh_list/src/core/theme/theme_notifier.dart';
import 'package:fresh_list/src/features/home/notifiers/grocery_list_notifier.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  enableFlutterDriverExtension();
  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(
    overrides: [
      localeNotifierProvider.overrideWith(_EnglishLocaleController.new),
      themeNotifierProvider.overrideWith(_LightThemeController.new),
      dynamicColorNotifierProvider.overrideWith(_NoDynamicColorController.new),
      watchRecentSearchesProvider.overrideWith(
        (_, _) => Stream.fromIterable([
          IList<RecentSearch>([
            RecentSearch(query: 'Strawberries', timestamp: DateTime(2024)),
          ]),
        ]),
      ),
    ],
  );
}

// Ignore the device settings and stored preferences so screenshots are stable.
class _EnglishLocaleController extends LocaleNotifier {
  @override
  Locale build() => const Locale('en', 'US');

  @override
  Future<void> init() async {}

  @override
  Future<void> setLocale(Locale locale) async => state = locale;
}

class _LightThemeController extends ThemeNotifier {
  @override
  ThemeMode build() => ThemeMode.light;

  @override
  Future<void> init() async {}

  @override
  Future<void> setThemeMode(ThemeMode mode) async => state = mode;
}

class _NoDynamicColorController extends DynamicColorNotifier {
  @override
  DynamicSchemeFactory? build() => null;

  @override
  Future<void> init() async {}
}
