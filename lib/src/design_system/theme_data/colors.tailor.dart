// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'colors.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppColorsTailorMixin
    on ThemeExtension<AppColors>, DiagnosticableTreeMixin {
  Color get primary;
  Color get background;
  Color get accent;
  Color get callToAction;
  Color get warning;

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? accent,
    Color? callToAction,
    Color? warning,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      accent: accent ?? this.accent,
      callToAction: callToAction ?? this.callToAction,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this as AppColors;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      callToAction: Color.lerp(callToAction, other.callToAction, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppColors &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality()
                .equals(background, other.background) &&
            const DeepCollectionEquality().equals(accent, other.accent) &&
            const DeepCollectionEquality()
                .equals(callToAction, other.callToAction) &&
            const DeepCollectionEquality().equals(warning, other.warning));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(accent),
      const DeepCollectionEquality().hash(callToAction),
      const DeepCollectionEquality().hash(warning),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppColors'))
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('accent', accent))
      ..add(DiagnosticsProperty('callToAction', callToAction))
      ..add(DiagnosticsProperty('warning', warning));
  }
}

extension AppColorsBuildContextProps on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  Color get primary => appColors.primary;
  Color get background => appColors.background;
  Color get accent => appColors.accent;
  Color get callToAction => appColors.callToAction;
  Color get warning => appColors.warning;
}
