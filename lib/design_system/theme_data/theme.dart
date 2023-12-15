import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final baseTheme = ThemeData.light();
    return baseTheme;
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    return baseTheme;
  }
}
