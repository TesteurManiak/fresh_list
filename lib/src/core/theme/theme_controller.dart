import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/theme_mode_extensions.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:material_ui/material_ui.dart';

final platformBrightnessProvider = Provider<Brightness>(
  (_) => PlatformDispatcher.instance.platformBrightness,
);

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

class ThemeController extends Notifier<ThemeMode> {
  static const themeKey = SharedPrefsKey.themeMode;

  @override
  ThemeMode build() => .system;

  /// Initialize the theme mode.
  ///
  /// Used to load something if the theme mode is not set by the device settings
  /// (e.g: from the local storage).
  Future<void> init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final themeModeIndex = prefs.getInt(themeKey.key) ?? ThemeMode.system.index;
    await setThemeMode(ThemeMode.values[themeModeIndex]);
  }

  /// Used to toggle between light and dark theme modes.
  Future<void> toggle() {
    final platformBrightness = ref.read(platformBrightnessProvider);
    final newMode = state.isPlatformDark(platformBrightness)
        ? ThemeMode.light
        : ThemeMode.dark;

    return setThemeMode(newMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(themeKey.key, mode.index);

    state = mode;
  }

  /// Used to reset the theme mode to the default theme mode.
  Future<void> reset() => setThemeMode(.system);
}
