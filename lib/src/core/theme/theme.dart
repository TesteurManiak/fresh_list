import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class const AppTheme._() {
  static const seedColor = MaterialColor(0xffF5A623, {});

  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      .android: FadeForwardsPageTransitionsBuilder(),
      .iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static ThemeData _themeBuilder(Brightness brightness) {
    final base = ThemeData(
      colorSchemeSeed: Colors.primaries.elementAt(12),
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
    );
  }

  static ThemeData light() => _themeBuilder(.light);
  static ThemeData dark() => _themeBuilder(.dark);
}
