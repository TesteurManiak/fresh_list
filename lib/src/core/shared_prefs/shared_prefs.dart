import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}

enum SharedPrefsKey {
  locale,
  themeMode;

  String get key => '$_prefix$name';

  static const _prefix = 'SPFreshList_';
}
