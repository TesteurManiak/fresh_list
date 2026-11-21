import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/mixins/initializable_notifier.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:fresh_list/src/core/theme/color_preset.dart';
import 'package:material_ui/material_ui.dart';

final colorPresetNotifierProvider =
    NotifierProvider<ColorPresetNotifier, ColorPreset>(ColorPresetNotifier.new);

final colorSeedProvider = Provider<Color?>(
  (ref) => ref.watch(colorPresetNotifierProvider.select((p) => p.color)),
);

class ColorPresetNotifier extends Notifier<ColorPreset>
    with InitializableNotifier {
  static const colorSchemeIndexKey = SharedPrefsKey.colorPreset;
  static const defaultPreset = ColorPreset.dynamic;

  @override
  ColorPreset build() {
    initOnBuild();
    return defaultPreset;
  }

  @override
  Future<void> performInit() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final index = prefs.getInt(colorSchemeIndexKey.key);
    state = .fromIndex(index ?? defaultPreset.index);
  }

  Future<void> setPreset(ColorPreset preset) async {
    if (preset == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(colorSchemeIndexKey.key, preset.index);
    state = preset;
  }

  Future<void> reset() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(colorSchemeIndexKey.key);
    state = defaultPreset;
  }
}
