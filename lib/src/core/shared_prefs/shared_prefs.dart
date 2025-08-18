import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

enum SharedPrefsKey {
  locale,
  themeMode,
  dbVersion;

  String get key => '$_prefix$name';

  static const _prefix = 'SPFreshList_';
}
