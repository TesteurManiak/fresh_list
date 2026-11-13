import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class const AppTheme._() {
  static ThemeData light() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFFFF8F6),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        backgroundColor: const Color(0xFFFFF8F6),
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        baseTheme.textTheme.copyWith(
          titleLarge: const TextStyle(
            color: Color(0xFF1F1B1A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
            height: 27.5 / 22,
            letterSpacing: -0.55,
          ),
        ),
      ),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: const Color(0xFFC85A32),
        secondary: const Color(0xFFD9822B),
        tertiary: const Color(0xFFF4B393),
        primaryContainer: const Color(0xFF9F3C16),
        onPrimaryContainer: Colors.white,
      ),
      listTileTheme: baseTheme.listTileTheme.copyWith(
        shape: const RoundedRectangleBorder(borderRadius: .all(.circular(16))),
        contentPadding: const EdgeInsets.all(12),
        tileColor: const Color(0xFFFCF1EF),
        selectedTileColor: Colors.white,
        iconColor: const Color(0xFF2E1500),
        titleTextStyle: const TextStyle(
          color: Color(0xFF1F1B1A),
          fontWeight: .w600,
          fontSize: 16,
          height: 20 / 16,
        ),
        subtitleTextStyle: const TextStyle(
          color: Color(0xFF57423B),
          fontWeight: FontWeight.normal,
          fontSize: 13,
          height: 18 / 13,
        ),
      ),
    );
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        baseTheme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            height: 27.5 / 22,
            letterSpacing: -0.55,
          ),
        ),
      ),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: const Color(0xFFE06D44),
        secondary: const Color(0xFFF59E0B),
        tertiary: const Color(0xFF8FB388),
      ),
      listTileTheme: baseTheme.listTileTheme.copyWith(
        shape: const RoundedRectangleBorder(borderRadius: .all(.circular(16))),
        contentPadding: const EdgeInsets.all(12),
        titleTextStyle: const TextStyle(
          fontWeight: .w600,
          fontSize: 16,
          height: 20 / 16,
        ),
        subtitleTextStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 13,
          height: 18 / 13,
        ),
      ),
    );
  }
}
