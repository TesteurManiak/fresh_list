import 'package:flutter/material.dart';
import 'package:todo_list/src/design_system/theme_data/colors.dart';
import 'package:todo_list/src/design_system/theme_data/typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final baseTheme = ThemeData.light();
    const colors = AppColors.light();
    const typography = AppTypography.regular();

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: colors.accent,
        background: colors.background,
        error: colors.warning,
      ),
      highlightColor: colors.callToAction,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
      ),
      extensions: const [
        colors,
        typography,
      ],
    );
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    const colors = AppColors.dark();
    const typography = AppTypography.regular();

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: colors.accent,
        background: colors.background,
        error: colors.warning,
      ),
      highlightColor: colors.callToAction,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
      ),
      extensions: const [
        colors,
        typography,
      ],
    );
  }
}
