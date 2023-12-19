import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:todo_list/src/design_system/theme_data/palette.dart';

part 'colors.tailor.dart';

@TailorMixin()
class AppColors extends ThemeExtension<AppColors>
    with DiagnosticableTreeMixin, _$AppColorsTailorMixin {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
  });

  const AppColors.light()
      : primary = ColorPalette.green,
        secondary = ColorPalette.orange,
        onSecondary = Colors.white,
        background = ColorPalette.lightGrey,
        surface = Colors.white;

  @override
  final Color primary;

  @override
  final Color secondary;

  @override
  final Color onSecondary;

  @override
  final Color background;

  @override
  final Color surface;
}
