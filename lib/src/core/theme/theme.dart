import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class const AppTheme._() {
  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      .android: FadeForwardsPageTransitionsBuilder(),
      .iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static ThemeData _themeBuilder(Brightness brightness, int seedIndex) {
    final base = ThemeData(
      colorSchemeSeed: Colors.primaries.elementAt(seedIndex),
      brightness: brightness,
    );

    return base.copyWith(
      textTheme: GoogleFonts.googleSansTextTheme(base.textTheme),
      pageTransitionsTheme: _pageTransitionsTheme,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: base.colorScheme.primary.withValues(alpha: 0.3),
        selectionHandleColor: base.colorScheme.primary,
        cursorColor: base.colorScheme.primary,
      ),
      dialogTheme: base.dialogTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: .circular(28)),
        clipBehavior: .antiAlias,
        backgroundColor: base.colorScheme.surfaceContainerHigh,
        iconColor: base.colorScheme.secondary,
        titleTextStyle: TextStyle(
          fontSize: 24,
          height: 32 / 24,
          fontWeight: .w400,
          color: base.colorScheme.onSurface,
        ),
      ),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: .circular(52)),
        clipBehavior: .antiAlias,
        constraints: const BoxConstraints(maxWidth: 560),
        showDragHandle: false,
        backgroundColor: base.colorScheme.surfaceContainerHigh,
      ),
    );
  }

  static ThemeData light(int seedIndex) => _themeBuilder(.light, seedIndex);
  static ThemeData dark(int seedIndex) => _themeBuilder(.dark, seedIndex);
}
