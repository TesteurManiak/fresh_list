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
    required this.background,
    required this.accent,
    required this.callToAction,
    required this.warning,
  });

  const AppColors.light()
      : primary = ColorPalette.green,
        background = Colors.white,
        accent = ColorPalette.lightGrey,
        callToAction = ColorPalette.blue,
        warning = ColorPalette.yellow;

  const AppColors.dark()
      : primary = ColorPalette.darkGreen,
        background = ColorPalette.charcoalBlack,
        accent = ColorPalette.lightGrey2,
        callToAction = ColorPalette.royalBlue,
        warning = ColorPalette.amber;

  @override
  final Color primary;

  @override
  final Color background;

  @override
  final Color accent;

  @override
  final Color callToAction;

  @override
  final Color warning;
}
