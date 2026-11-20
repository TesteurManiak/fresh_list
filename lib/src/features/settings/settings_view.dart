import 'dart:async';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/gen/version.dart';
import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/constants/consts.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/localization/locale_controller.dart';
import 'package:fresh_list/src/core/theme/theme_controller.dart';
import 'package:fresh_list/src/core/utils/haptics_helper.dart';
import 'package:fresh_list/src/core/widgets/app_icon.dart';
import 'package:fresh_list/src/core/widgets/bottom_padding.dart';
import 'package:fresh_list/src/features/settings/widgets/language_sheet.dart';
import 'package:fresh_list/src/features/settings/widgets/menu_section.dart';
import 'package:fresh_list/src/features/settings/widgets/menu_tile.dart';
import 'package:fresh_list/src/features/settings/widgets/no_mail_app_snack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class SettingsView extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final cs = ColorScheme.of(context);
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
                        ref
                            .read(themeControllerProvider.notifier)
                            .setThemeMode(selection.first);
                        HapticsHelper.selection();
                      },
                    );
                  },
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  final currentLocale = ref.watch(localeControllerProvider);
                  return MenuTile(
                    icon: Icons.language,
                    title: strings.settings_language_title,
                    trailing: Text(currentLocale.label(strings)),
                    onTap: () async {
                      final locale = await const LanguageSheet().show(context);
                      if (locale == null || locale == currentLocale) return;
                      unawaited(
                        ref
                            .read(localeControllerProvider.notifier)
                            .setLocale(locale),
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
                onTap: () => contactSupport(strings),
              ),
            ],
          ),
          const SizedBox(height: 64),
          GestureDetector(
            behavior: .opaque,
            onTap: () => showAboutDialog(
              context: context,
              applicationName: AppConstants.appName,
              applicationVersion: packageVersion,
              applicationIcon: const AppIcon(),
            ),
            child: Column(
              spacing: 8,
              children: [
                const AppIcon(),
                Text(
                  '${AppConstants.appName} $packageVersion',
                  textAlign: .center,
                  style: GoogleFonts.googleSansCode(
                    textStyle: textTheme.labelSmall,
                    color: cs.outline,
                    fontFeatures: const [.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> contactSupport(AppLocalizations strings) async {
    try {
      await FlutterEmailSender.send(
        Email(
          recipients: [AppConstants.supportEmail],
          subject: strings.support_email_subject,
        ),
      );
    } on FlutterEmailSenderNotAvailableException {
      if (!mounted) return;

      const NoMailAppSnack().show(context);
    }
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
