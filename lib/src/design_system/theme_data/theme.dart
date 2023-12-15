import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(centerTitle: true),
    );
  }

  static ThemeData dark() {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(centerTitle: true),
    );
  }
}
