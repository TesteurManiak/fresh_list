import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

enum SharedPrefsKey {
  locale,
  themeMode,
  dbVersion,
  swipeHintShown;

  String get key => '$_prefix$name';

  static const _prefix = 'SPFreshList_';
}
