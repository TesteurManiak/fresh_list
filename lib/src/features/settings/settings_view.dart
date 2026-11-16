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
import 'package:todo_list/src/core/widgets/coming_soon_snack.dart';
import 'package:todo_list/src/features/settings/widgets/language_sheet.dart';
import 'package:todo_list/src/features/settings/widgets/menu_section.dart';
import 'package:todo_list/src/features/settings/widgets/menu_tile.dart';

class SettingsView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: .fromLTRB(16, 8, 16, BottomPadding.of(context)),
        children: <Widget>[
          MenuSection(
            label: strings.settings_preferences_title,
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
                            icon: Icon(
                              mode.icon,
                              key: Key('theme_${mode.name}'),
                            ),
                            tooltip: mode.label(strings),
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
              Consumer(
                builder: (context, ref, _) {
                  final locale = ref.watch(localeControllerProvider);
                  return MenuTile(
                    icon: Icons.language,
                    title: strings.settings_language_title,
                    trailing: Text(locale.label(strings)),
                    onTap: () async {
                      final newLocale = await const LanguageSheet().show(
                        context,
                      );
                      if (newLocale == null || newLocale == locale) return;
                      unawaited(
                        ref
                            .read(localeControllerProvider.notifier)
                            .setLocale(newLocale),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          MenuSection(
            label: strings.settings_support_title,
            children: [
              MenuTile(
                icon: Icons.alternate_email_outlined,
                title: strings.settings_report_issue,
                onTap: () {
                  // TODO(Guillaume): Implement issue reporting
                  const ComingSoonSnack().show(context);
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
