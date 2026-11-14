import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';
import 'package:todo_list/src/core/localization/locale_controller.dart';
import 'package:todo_list/src/core/mixins/showable.dart';
import 'package:todo_list/src/core/widgets/app_sheet.dart';

class LanguageSheet extends ConsumerWidget
    with ShowableBottomSheetMixin<Locale> {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final currentLocale = ref.watch(localeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return AppSheet(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final locale = supportedLocales[index];
          final selected = locale == currentLocale;

          return Material(
            color: selected
                ? colorScheme.secondaryContainer
                : colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: _LocaleTile.radiusFor(
                index,
                supportedLocales.length,
                selected,
              ),
            ),
            clipBehavior: .antiAlias,
            child: _LocaleTile(locale, selected: selected),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 4),
        itemCount: supportedLocales.length,
      ),
    );
  }
}

class _LocaleTile extends StatelessWidget {
  const new(this.locale, {required this.selected});

  final Locale locale;
  final bool selected;

  // M3 Expressive outer vs. inner radii + pill morph on selection
  static BorderRadius radiusFor(int index, int length, bool selected) {
    const Radius outer = .circular(20);
    const Radius inner = .circular(6);

    return selected
        ? .circular(28)
        : .vertical(
            top: index == 0 ? outer : inner,
            bottom: index == length - 1 ? outer : inner,
          );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => Navigator.maybePop(context, locale),
      child: Padding(
        padding: const .symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                locale.label(strings),
                style: GoogleFonts.googleSans(
                  textStyle: textTheme.titleMedium,
                  fontWeight: selected ? .w700 : .w500,
                  color: selected
                      ? colorScheme.onSecondaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle_rounded,
                color: colorScheme.onSecondaryContainer,
              ),
          ],
        ),
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
