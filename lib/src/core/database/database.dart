import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/core/shared_prefs/shared_prefs.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
class IsarDb extends _$IsarDb {
  @override
  Future<Isar> build() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [],
      directory: dir.path,
    );

    await _performMigrationIfNeeded(isar);

    ref.onDispose(isar.close);

    return isar;
  }

  static const version = 1;
  static const sharedPrefsKey = SharedPrefsKey.dbVersion;

  Future<void> _performMigrationIfNeeded(Isar isar) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final cacheVersion = prefs.getInt(sharedPrefsKey.key);
    if (cacheVersion == version) return;

    // Handle migrations here

    await prefs.setInt(sharedPrefsKey.key, version);
  }
}
