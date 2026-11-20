import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';
import 'package:material_ui/material_ui.dart';

const kDefaultSeedIndex = 12;

final colorSchemeSeedControllerProvider =
    NotifierProvider<ColorSchemeSeedController, int>(
      ColorSchemeSeedController.new,
    );

class ColorSchemeSeedController extends Notifier<int> {
  static const colorSchemeIndexKey = SharedPrefsKey.colorSchemeIndex;

  @override
  int build() => kDefaultSeedIndex;

  Future<void> init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final index = prefs.getInt(colorSchemeIndexKey.key) ?? kDefaultSeedIndex;
    await setSeedIndex(index);
  }

  Future<void> setSeedIndex(int index) async {
    final newIndex = index.clamp(0, Colors.primaries.length - 1);
    if (newIndex == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(colorSchemeIndexKey.key, newIndex);
    state = newIndex;
  }

  Future<void> reset() => setSeedIndex(kDefaultSeedIndex);
}
