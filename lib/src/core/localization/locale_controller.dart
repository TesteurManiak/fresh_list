import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/shared_prefs/shared_prefs.dart';

typedef LocalizedString = String Function(AppLocalizations strings);

final fallbackLocaleProvider = Provider<Locale>(
  (_) => AppLocalizations.supportedLocales.first,
);

final systemLocaleProvider = Provider<Locale>((ref) {
  final fallback = ref.watch(fallbackLocaleProvider);
  final locale = _resolveLocale(PlatformDispatcher.instance.locale, fallback);

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

final localeControllerProvider = NotifierProvider<LocaleController, Locale>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale> {
  static const SharedPrefsKey localeKey = SharedPrefsKey.locale;

  @override
  Locale build() {
    final system = ref.watch(systemLocaleProvider);
    final fallback = ref.watch(fallbackLocaleProvider);

    return _resolveLocale(system, fallback);
  }

  /// Initialize the locale.
  ///
  /// Used to load something if the locale is not set by the device settings
  /// (e.g: from the local storage).
  Future<void> init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final locale = prefs.getString(localeKey.key);

    if (locale != null) await setLocale(Locale(locale));
  }

  /// Used to set the locale if it is supported.
  Future<void> setLocale(Locale locale) async {
    final newLocale = _resolveLocale(locale);
    if (newLocale == state) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(localeKey.key, newLocale.languageCode);

    state = newLocale;
  }

  /// Used to reset the locale to the system locale.
  Future<void> reset() {
    return setLocale(ref.read(systemLocaleProvider));
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
