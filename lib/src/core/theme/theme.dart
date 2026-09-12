import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class const AppTheme._() {
  static ThemeData light() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: const Color(0xFFC85A32),
        secondary: const Color(0xFFD9822B),
        tertiary: const Color(0xFFF4B393),
      ),
    );
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      textTheme: GoogleFonts.epilogueTextTheme(baseTheme.textTheme),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: const Color(0xFFE06D44),
        secondary: const Color(0xFFF59E0B),
        tertiary: const Color(0xFF8FB388),
      ),
    );
  }
}
