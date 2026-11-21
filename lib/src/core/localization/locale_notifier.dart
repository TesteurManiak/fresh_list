import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/mixins/initializable_notifier.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';

typedef LocalizedString = String Function(AppLocalizations strings);

final systemLocaleProvider = Provider<Locale>((ref) {
  final locale = _resolveLocale(
    PlatformDispatcher.instance.locale,
    LocaleNotifier.fallbackLocale,
  );

  final observer = _LocaleObserver((_) => ref.invalidateSelf());
  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return locale;
});

class _LocaleObserver(final ValueChanged<List<Locale>?> _didChangeLocales)
    extends WidgetsBindingObserver {
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> with InitializableNotifier {
  static const localeKey = SharedPrefsKey.locale;
  static final fallbackLocale = AppLocalizations.supportedLocales.first;

  Locale? _cachedSavedLocale;

  @override
  Locale build() {
    ref.onDispose(() => _cachedSavedLocale = null);
    initOnBuild();

    final system = ref.watch(systemLocaleProvider);
    return _cachedSavedLocale ?? _resolveLocale(system, fallbackLocale);
  }

  @override
  Future<void> performInit() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final savedCode = prefs.getString(localeKey.key);

    if (savedCode == null) return;

    final resolved = _resolveLocale(Locale(savedCode));
    _cachedSavedLocale = resolved;
    await setLocale(resolved);
  }

  /// Used to set the locale if it is supported.
  Future<void> setLocale(Locale locale) async {
    final newLocale = _resolveLocale(locale);
    if (newLocale == state && _cachedSavedLocale == newLocale) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(localeKey.key, newLocale.languageCode);

    _cachedSavedLocale = newLocale;
    state = newLocale;
  }

  /// Used to reset the locale to the system locale.
  Future<void> reset() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(localeKey.key);

    _cachedSavedLocale = null;
    state = _resolveLocale(ref.read(systemLocaleProvider), fallbackLocale);
  }
}

Locale _resolveLocale(Locale locale, [Locale? fallback]) {
  if (AppLocalizations.delegate.isSupported(locale)) {
    return AppLocalizations.supportedLocales.localeOf(locale);
  }

  if (fallback != null && AppLocalizations.delegate.isSupported(fallback)) {
    return AppLocalizations.supportedLocales.localeOf(fallback);
  }

  return AppLocalizations.supportedLocales.first;
}

extension on List<Locale> {
  Locale localeOf(Locale locale) {
    return firstWhere(
      (e) => e.languageCode == locale.languageCode,
      orElse: () => first,
    );
  }
}
