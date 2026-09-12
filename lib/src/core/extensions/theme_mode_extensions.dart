import 'package:flutter/material.dart';

extension ThemeModeExtensions on ThemeMode {
  /// Returns whether this theme mode is dark.
  ///
  /// [platformBrightness] is required to determine whether [ThemeMode.system]
  /// is dark or light.
  bool isPlatformDark(Brightness platformBrightness) {
    return switch (this) {
      .system => platformBrightness == .dark,
      .light => false,
      .dark => true,
    };
  }
}
