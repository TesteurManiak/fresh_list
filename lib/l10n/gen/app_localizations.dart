// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @generic_error.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite. Veuillez réessayer plus tard.'**
  String get generic_error;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @empty_grocery_list.
  ///
  /// In fr, this message translates to:
  /// **'Votre liste est vide.\nAjoutez des articles en appuyant sur le bouton \"+\".'**
  String get empty_grocery_list;

  /// No description provided for @settings_title.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings_title;

  /// No description provided for @quick_action_share.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get quick_action_share;

  /// No description provided for @quick_action_edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get quick_action_edit;

  /// No description provided for @quick_action_delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get quick_action_delete;

  /// No description provided for @add_grocery.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter à la liste'**
  String get add_grocery;

  /// No description provided for @edit_grocery.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'entrée'**
  String get edit_grocery;

  /// No description provided for @mark_as_bought.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme acheté'**
  String get mark_as_bought;

  /// No description provided for @product_name.
  ///
  /// In fr, this message translates to:
  /// **'Nom du produit'**
  String get product_name;

  /// No description provided for @frequent_suggestions.
  ///
  /// In fr, this message translates to:
  /// **'Suggestions fréquentes'**
  String get frequent_suggestions;

  /// No description provided for @settings_preferences_title.
  ///
  /// In fr, this message translates to:
  /// **'Préférences'**
  String get settings_preferences_title;

  /// No description provided for @settings_theme_title.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settings_theme_title;

  /// No description provided for @theme_mode_system.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get theme_mode_system;

  /// No description provided for @theme_mode_light.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get theme_mode_light;

  /// No description provided for @theme_mode_dark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get theme_mode_dark;

  /// No description provided for @settings_language_title.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settings_language_title;

  /// No description provided for @language_en.
  ///
  /// In fr, this message translates to:
  /// **'Anglais'**
  String get language_en;

  /// No description provided for @language_fr.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get language_fr;

  /// No description provided for @settings_about_title.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get settings_about_title;

  /// No description provided for @added.
  ///
  /// In fr, this message translates to:
  /// **'Ajouté'**
  String get added;

  /// No description provided for @clear_all.
  ///
  /// In fr, this message translates to:
  /// **'Effacer la liste'**
  String get clear_all;

  /// No description provided for @clear_all_confirmation_title.
  ///
  /// In fr, this message translates to:
  /// **'Effacer tous les articles ?'**
  String get clear_all_confirmation_title;

  /// No description provided for @clear_all_confirmation_message.
  ///
  /// In fr, this message translates to:
  /// **'Cela supprimera définitivement tous les articles de votre liste.'**
  String get clear_all_confirmation_message;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @coming_soon.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt disponible !'**
  String get coming_soon;

  /// No description provided for @settings_support_title.
  ///
  /// In fr, this message translates to:
  /// **'Assistance'**
  String get settings_support_title;

  /// No description provided for @settings_report_issue.
  ///
  /// In fr, this message translates to:
  /// **'Signaler un problème'**
  String get settings_report_issue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
