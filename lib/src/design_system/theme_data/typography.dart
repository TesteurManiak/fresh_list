import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'typography.tailor.dart';

@TailorMixin()
class AppTypography extends ThemeExtension<AppTypography>
    with DiagnosticableTreeMixin, _$AppTypographyTailorMixin {
  const AppTypography({
    required this.appBar,
    required this.listTileTitle,
    required this.listTileSubtitle,
    required this.callToAction,
    required this.body,
    required this.warning,
  });

  const AppTypography.regular()
      : appBar = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        listTileTitle = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        listTileSubtitle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        callToAction = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        body = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        warning = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        );

  @override
  final TextStyle appBar;

  @override
  final TextStyle listTileTitle;

  @override
  final TextStyle listTileSubtitle;

  @override
  final TextStyle callToAction;

  @override
  final TextStyle body;

  @override
  final TextStyle warning;
}
