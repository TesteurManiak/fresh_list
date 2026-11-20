import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:fresh_list/src/core/theme/color_preset.dart';
import 'package:material_ui/material_ui.dart';

final colorPresetControllerProvider =
    NotifierProvider<ColorPresetController, ColorPreset>(
      ColorPresetController.new,
    );

final colorSeedProvider = Provider<Color?>(
  (ref) => ref.watch(colorPresetControllerProvider.select((p) => p.color)),
);

class ColorPresetController extends Notifier<ColorPreset> {
  static const colorSchemeIndexKey = SharedPrefsKey.colorPreset;

  @override
  ColorPreset build() => .dynamic;

  Future<void> init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final index = prefs.getInt(colorSchemeIndexKey.key);

    await setPreset(ColorPreset.fromIndex(index ?? ColorPreset.dynamic.index));
  }

  Future<void> setPreset(ColorPreset preset) async {
    if (preset == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(colorSchemeIndexKey.key, preset.index);
    state = preset;
  }

  Future<void> reset() => setPreset(.dynamic);
}
