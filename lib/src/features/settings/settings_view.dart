import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/gen/version.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/constants/consts.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/theme/theme_controller.dart';
import 'package:todo_list/src/core/utils/haptics_helper.dart';
import 'package:todo_list/src/core/widgets/app_icon.dart';
import 'package:todo_list/src/core/widgets/bottom_padding.dart';
import 'package:todo_list/src/features/home/controllers/grocery_list_controller.dart';
import 'package:todo_list/src/features/settings/widgets/clear_all_confirmation_dialog.dart';
import 'package:todo_list/src/features/settings/widgets/menu_section.dart';
import 'package:todo_list/src/features/settings/widgets/menu_tile.dart';

class SettingsView extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final locale = ref.watch(localeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings_title)),
      body: ListView(
        padding: .fromLTRB(16, 8, 16, BottomPadding.of(context)),
        children: <Widget>[
          MenuSection(
            // TODO(Guillaume): localize
            label: 'Preferences',
            children: [
              MenuTile(
                icon: Icons.brightness_6_outlined,
                title: strings.settings_theme_title,
                trailing: Consumer(
                  builder: (context, ref, _) {
                    final themeMode = ref.watch(themeControllerProvider);

                    return SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: .compact,
                        tapTargetSize: .shrinkWrap,
                      ),
                      selected: {themeMode},
                      segments: [
                        for (final mode in ThemeMode.values)
                          ButtonSegment(
                            value: mode,
                            icon: Icon(mode.icon),
                            label: Text(mode.label(strings)),
                          ),
                      ],
                      onSelectionChanged: (selection) {
                        unawaited(
                          ref
                              .read(themeControllerProvider.notifier)
                              .setThemeMode(selection.first),
                        );
                        unawaited(HapticsHelper.selection());
                      },
                    );
                  },
                ),
              ),
              MenuTile(
                icon: Icons.language,
                title: strings.settings_language_title,
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
            ],
          ),
          const SizedBox(height: 32),
          MenuSection(
            children: [
              MenuTile(
                icon: Icons.clear_all,
                title: strings.clear_all,
                onTap: () async {
                  final confirmed = await const ClearAllConfirmationDialog()
                      .show(context);

                  if (confirmed != true || !context.mounted) return;

                  unawaited(
                    ref
                        .read(groceryListControllerProvider.notifier)
                        .clearGroceries(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 64),
          Column(
            spacing: 8,
            children: [
              const AppIcon(size: 24),
              Text(
                '${AppConstants.appName} $packageVersion',
                textAlign: .center,
                style: GoogleFonts.googleSansCode(
                  textStyle: textTheme.labelSmall,
                  color: colorScheme.outline,
                  fontFeatures: const [.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on ThemeMode {
  IconData get icon => switch (this) {
    .system => Icons.brightness_auto_rounded,
    .light => Icons.light_mode_rounded,
    .dark => Icons.dark_mode_rounded,
  };

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
