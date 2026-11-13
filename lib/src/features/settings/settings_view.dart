import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/gen/version.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/constants/consts.dart';
import 'package:todo_list/src/core/extensions/iterable_extensions.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';
import 'package:todo_list/src/core/widgets/app_icon.dart';
import 'package:todo_list/src/core/widgets/tile_icon.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/settings/widgets/clear_all_confirmation_dialog.dart';

class SettingsView extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings_title)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          ListTile(
            leading: const TileIcon(Icons.brightness_6),
            title: Text(strings.settings_theme_title),
            trailing: PopupMenuButton<ThemeMode>(
              initialValue: themeMode,
              onSelected: (mode) {
                unawaited(
                  ref.read(themeControllerProvider.notifier).setThemeMode(mode),
                );
              },
              child: Text(themeMode.label(strings)),
              itemBuilder: (context) => ThemeMode.values
                  .map(
                    (mode) => PopupMenuItem<ThemeMode>(
                      value: mode,
                      child: Text(mode.label(strings)),
                    ),
                  )
                  .toList(),
            ),
          ),
          ListTile(
            leading: const TileIcon(Icons.language),
            title: Text(strings.settings_language_title),
            trailing: PopupMenuButton<Locale>(
              initialValue: locale,
              onSelected: (newLocale) {
                unawaited(
                  ref
                      .read(localeControllerProvider.notifier)
                      .setLocale(newLocale),
                );
              },
              child: Text(locale.label(strings)),
              itemBuilder: (context) => AppLocalizations.supportedLocales
                  .map(
                    (supportedLocale) => PopupMenuItem<Locale>(
                      value: supportedLocale,
                      child: Text(supportedLocale.label(strings)),
                    ),
                  )
                  .toList(),
            ),
          ),
          ListTile(
            leading: const TileIcon(Icons.clear_all),
            title: Text(strings.clear_all),
            onTap: () async {
              final confirmed = await const ClearAllConfirmationDialog().show(
                context,
              );

              if (confirmed != true || !context.mounted) return;

              unawaited(
                ref
                    .read(groceryListControllerProvider.notifier)
                    .clearGroceries(),
              );
            },
          ),
          ListTile(
            leading: const TileIcon(Icons.info),
            title: Text(strings.settings_about_title),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: AppConstants.appName,
              applicationIcon: const AppIcon(),
              applicationVersion: 'v$packageVersion',
            ),
          ),
        ].separatedWith(const SizedBox(height: 8)).toList(),
      ),
    );
  }
}

extension on ThemeMode {
  String label(AppLocalizations strings) => switch (this) {
    .system => strings.theme_mode_system,
    .light => strings.theme_mode_light,
    .dark => strings.theme_mode_dark,
  };
}

extension on Locale {
  String label(AppLocalizations strings) => switch (languageCode) {
    'fr' => strings.language_fr,
    _ => strings.language_en,
  };
}
