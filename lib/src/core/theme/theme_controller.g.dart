// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$defaultThemeModeHash() => r'266a2a0779b5bbeedd555e2ae70d9dcacc70bf83';

/// See also [defaultThemeMode].
@ProviderFor(defaultThemeMode)
final defaultThemeModeProvider = Provider<ThemeMode>.internal(
  defaultThemeMode,
  name: r'defaultThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$defaultThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DefaultThemeModeRef = ProviderRef<ThemeMode>;
String _$lightThemeHash() => r'8575e2483263b13545511fd244b3b4eaa3dfa203';

/// See also [lightTheme].
@ProviderFor(lightTheme)
final lightThemeProvider = Provider<ThemeData>.internal(
  lightTheme,
  name: r'lightThemeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lightThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LightThemeRef = ProviderRef<ThemeData>;
String _$darkThemeHash() => r'bbe5d8a2603221176ca659cfdc7cce29f5ecb1ba';

/// See also [darkTheme].
@ProviderFor(darkTheme)
final darkThemeProvider = Provider<ThemeData>.internal(
  darkTheme,
  name: r'darkThemeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$darkThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DarkThemeRef = ProviderRef<ThemeData>;
String _$platformBrightnessHash() =>
    r'd216448d440fab4a6896f853ce1af0c9f7918b34';

/// See also [platformBrightness].
@ProviderFor(platformBrightness)
final platformBrightnessProvider = AutoDisposeProvider<Brightness>.internal(
  platformBrightness,
  name: r'platformBrightnessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$platformBrightnessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlatformBrightnessRef = AutoDisposeProviderRef<Brightness>;
String _$themeControllerHash() => r'138fd68a74bf8a1830d7ff14fa9cb6c6674c0ca9';

/// See also [ThemeController].
@ProviderFor(ThemeController)
final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>.internal(
  ThemeController.new,
  name: r'themeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeController = Notifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
