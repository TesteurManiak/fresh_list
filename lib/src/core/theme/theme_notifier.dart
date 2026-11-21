import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/extensions/theme_mode_extensions.dart';
import 'package:fresh_list/src/core/mixins/initializable_notifier.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:material_ui/material_ui.dart';

final platformBrightnessProvider = Provider<Brightness>((ref) {
  final brightness = PlatformDispatcher.instance.platformBrightness;

  final observer = _BrightnessObserver(() => ref.invalidateSelf());
  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return brightness;
});

class _BrightnessObserver(final VoidCallback _didChangeBrightness)
    extends WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() => _didChangeBrightness();
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeMode> with InitializableNotifier {
  static const themeKey = SharedPrefsKey.themeMode;

  @override
  ThemeMode build() {
    initOnBuild();
    return .system;
  }

  ThemeMode _parseThemeMode(int? index) {
    if (index == null || index < 0 || index >= ThemeMode.values.length) {
      return .system;
    }
    return ThemeMode.values[index];
  }

  @override
  Future<void> performInit() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = _parseThemeMode(prefs.getInt(themeKey.key));
  }

  /// Used to toggle between light and dark theme modes.
  Future<void> toggle() {
    final platformBrightness = ref.read(platformBrightnessProvider);
    final ThemeMode newMode = state.isPlatformDark(platformBrightness)
        ? .light
        : .dark;

    return setThemeMode(newMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(themeKey.key, mode.index);

    state = mode;
  }

  /// Used to reset the theme mode to the default theme mode.
  Future<void> reset() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(themeKey.key);
    state = .system;
  }
}
