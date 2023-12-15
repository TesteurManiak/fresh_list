// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'typography.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppTypographyTailorMixin
    on ThemeExtension<AppTypography>, DiagnosticableTreeMixin {
  TextStyle get appBar;
  TextStyle get listTileTitle;
  TextStyle get listTileSubtitle;
  TextStyle get callToAction;
  TextStyle get body;
  TextStyle get warning;

  @override
  AppTypography copyWith({
    TextStyle? appBar,
    TextStyle? listTileTitle,
    TextStyle? listTileSubtitle,
    TextStyle? callToAction,
    TextStyle? body,
    TextStyle? warning,
  }) {
    return AppTypography(
      appBar: appBar ?? this.appBar,
      listTileTitle: listTileTitle ?? this.listTileTitle,
      listTileSubtitle: listTileSubtitle ?? this.listTileSubtitle,
      callToAction: callToAction ?? this.callToAction,
      body: body ?? this.body,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this as AppTypography;
    return AppTypography(
      appBar: TextStyle.lerp(appBar, other.appBar, t)!,
      listTileTitle: TextStyle.lerp(listTileTitle, other.listTileTitle, t)!,
      listTileSubtitle:
          TextStyle.lerp(listTileSubtitle, other.listTileSubtitle, t)!,
      callToAction: TextStyle.lerp(callToAction, other.callToAction, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      warning: TextStyle.lerp(warning, other.warning, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppTypography &&
            const DeepCollectionEquality().equals(appBar, other.appBar) &&
            const DeepCollectionEquality()
                .equals(listTileTitle, other.listTileTitle) &&
            const DeepCollectionEquality()
                .equals(listTileSubtitle, other.listTileSubtitle) &&
            const DeepCollectionEquality()
                .equals(callToAction, other.callToAction) &&
            const DeepCollectionEquality().equals(body, other.body) &&
            const DeepCollectionEquality().equals(warning, other.warning));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(appBar),
      const DeepCollectionEquality().hash(listTileTitle),
      const DeepCollectionEquality().hash(listTileSubtitle),
      const DeepCollectionEquality().hash(callToAction),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(warning),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppTypography'))
      ..add(DiagnosticsProperty('appBar', appBar))
      ..add(DiagnosticsProperty('listTileTitle', listTileTitle))
      ..add(DiagnosticsProperty('listTileSubtitle', listTileSubtitle))
      ..add(DiagnosticsProperty('callToAction', callToAction))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('warning', warning));
  }
}

extension AppTypographyBuildContextProps on BuildContext {
  AppTypography get appTypography => Theme.of(this).extension<AppTypography>()!;
  TextStyle get appBar => appTypography.appBar;
  TextStyle get listTileTitle => appTypography.listTileTitle;
  TextStyle get listTileSubtitle => appTypography.listTileSubtitle;
  TextStyle get callToAction => appTypography.callToAction;
  TextStyle get body => appTypography.body;
  TextStyle get warning => appTypography.warning;
}
