import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/extensions/build_context_extensions.dart';
import 'package:fresh_list/src/core/localization/locale_controller.dart';
import 'package:fresh_list/src/core/mixins/showable.dart';
import 'package:fresh_list/src/core/widgets/app_sheet.dart';
import 'package:fresh_list/src/core/widgets/sheet_tile.dart';
import 'package:material_ui/material_ui.dart';

class LanguageSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<Locale> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final currentLocale = ref.watch(localeControllerProvider);
    final strings = context.strings;

    return AppSheet(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: supportedLocales.length,
        separatorBuilder: (_, _) => const SizedBox(height: SheetTile.gap),
        itemBuilder: (context, index) {
          final locale = supportedLocales[index];
          final selected = locale == currentLocale;

          return SheetTile(
            title: locale.label(strings),
            selected: selected,
            borderRadius: SheetTile.radiusFor(
              index,
              supportedLocales.length,
              selected,
            ),
            onTap: () => Navigator.maybePop(context, locale),
          );
        },
      ),
    );
  }
}

extension LocaleLabel on Locale {
  String label(AppLocalizations strings) => switch (languageCode) {
    'fr' => strings.language_fr,
    'en' => strings.language_en,
    _ => languageCode.toUpperCase(),
  };
}
