import 'package:flutter/material.dart';
import 'package:todo_list/src/design_system/theme_data/colors.dart';
import 'package:todo_list/src/design_system/theme_data/typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final baseTheme = ThemeData.light();
    const colors = AppColors.light();
    const typography = AppTypography.regular();

    return baseTheme.copyWith(
      brightness: Brightness.light,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        clipBehavior: Clip.antiAlias,
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

    return baseTheme.copyWith(
      brightness: Brightness.dark,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true,
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        clipBehavior: Clip.antiAlias,
      ),
      extensions: const [
        colors,
        typography,
      ],
    );
  }
}
