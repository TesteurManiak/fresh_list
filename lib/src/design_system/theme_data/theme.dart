import 'package:flutter/material.dart';
import 'package:todo_list/src/design_system/theme_data/colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final baseTheme = ThemeData.light();
    const colors = AppColors.light();

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        background: colors.background,
        surface: colors.surface,
      ),
      scaffoldBackgroundColor: colors.background,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: colors.secondary,
        foregroundColor: colors.onSecondary,
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        clipBehavior: Clip.antiAlias,
      ),
      extensions: const [
        colors,
      ],
    );
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();

    return baseTheme.copyWith(
      brightness: Brightness.dark,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        clipBehavior: Clip.antiAlias,
      ),
      extensions: const [],
    );
  }
}
