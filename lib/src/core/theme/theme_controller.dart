import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/extensions/theme_mode_extensions.dart';
import 'package:todo_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:todo_list/src/design_system/theme_data/theme.dart';

part 'theme_controller.g.dart';

@Riverpod(keepAlive: true)
ThemeMode defaultThemeMode(DefaultThemeModeRef ref) => ThemeMode.system;

@Riverpod(keepAlive: true)
ThemeData lightTheme(LightThemeRef ref) => AppTheme.light();

@Riverpod(keepAlive: true)
ThemeData darkTheme(DarkThemeRef ref) => AppTheme.dark();

@riverpod
Brightness platformBrightness(PlatformBrightnessRef ref) {
  return PlatformDispatcher.instance.platformBrightness;
}

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  static const themeKey = SharedPrefsKey.themeMode;

  @override
  ThemeMode build() {
    return ref.read(defaultThemeModeProvider);
  }

  /// Initialize the theme mode.
  ///
  /// Used to load something if the theme mode is not set by the device settings
  /// (e.g: from the local storage).
  Future<void> init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final themeModeIndex = prefs.getInt(themeKey.key) ?? ThemeMode.system.index;

    return setThemeMode(ThemeMode.values[themeModeIndex]);
  }

  /// Used to toggle between light and dark theme modes.
  Future<void> toggle() {
    final platformBrightness = ref.read(platformBrightnessProvider);
    final newMode =
        state.isDark(platformBrightness) ? ThemeMode.light : ThemeMode.dark;

    return setThemeMode(newMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(themeKey.key, mode.index);

    state = mode;
  }

  /// Used to reset the theme mode to the default theme mode.
  Future<void> reset() {
    return setThemeMode(ref.read(defaultThemeModeProvider));
  }
}
