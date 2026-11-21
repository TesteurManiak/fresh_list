import 'package:fresh_list/l10n/gen/app_localizations.dart';
import 'package:fresh_list/src/core/localization/locale_notifier.dart';
import 'package:material_ui/material_ui.dart';

enum ColorPreset(final Color? color, final LocalizedString label) {
  dynamic(null, _dynamic),
  red(Colors.red, _red),
  pink(Colors.pink, _pink),
  purple(Colors.purple, _purple),
  deepPurple(Colors.deepPurple, _deepPurple),
  indigo(Colors.indigo, _indigo),
  blue(Colors.blue, _blue),
  lightBlue(Colors.lightBlue, _lightBlue),
  cyan(Colors.cyan, _cyan),
  teal(Colors.teal, _teal),
  green(Colors.green, _green),
  lightGreen(Colors.lightGreen, _lightGreen),
  lime(Colors.lime, _lime),
  yellow(Colors.yellow, _yellow),
  amber(Colors.amber, _amber),
  orange(Colors.orange, _orange),
  deepOrange(Colors.deepOrange, _deepOrange),
  brown(Colors.brown, _brown),
  blueGrey(Colors.blueGrey, _blueGrey);

  factory fromIndex(int index) {
    if (index < 0 || index >= ColorPreset.values.length) {
      return .dynamic;
    }
    return ColorPreset.values[index];
  }

  static String _dynamic(AppLocalizations strings) =>
      strings.settings_theme_color_dynamic;

  static String _red(AppLocalizations strings) =>
      strings.settings_theme_color_red;

  static String _pink(AppLocalizations strings) =>
      strings.settings_theme_color_pink;

  static String _purple(AppLocalizations strings) =>
      strings.settings_theme_color_purple;

  static String _deepPurple(AppLocalizations strings) =>
      strings.settings_theme_color_deep_purple;

  static String _indigo(AppLocalizations strings) =>
      strings.settings_theme_color_indigo;

  static String _blue(AppLocalizations strings) =>
      strings.settings_theme_color_blue;

  static String _lightBlue(AppLocalizations strings) =>
      strings.settings_theme_color_light_blue;

  static String _cyan(AppLocalizations strings) =>
      strings.settings_theme_color_cyan;

  static String _teal(AppLocalizations strings) =>
      strings.settings_theme_color_teal;

  static String _green(AppLocalizations strings) =>
      strings.settings_theme_color_green;

  static String _lightGreen(AppLocalizations strings) =>
      strings.settings_theme_color_light_green;

  static String _lime(AppLocalizations strings) =>
      strings.settings_theme_color_lime;

  static String _yellow(AppLocalizations strings) =>
      strings.settings_theme_color_yellow;

  static String _amber(AppLocalizations strings) =>
      strings.settings_theme_color_amber;

  static String _orange(AppLocalizations strings) =>
      strings.settings_theme_color_orange;

  static String _deepOrange(AppLocalizations strings) =>
      strings.settings_theme_color_deep_orange;

  static String _brown(AppLocalizations strings) =>
      strings.settings_theme_color_brown;

  static String _blueGrey(AppLocalizations strings) =>
      strings.settings_theme_color_blue_grey;
}
