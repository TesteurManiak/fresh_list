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

  /// No description provided for @add_grocery.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add_grocery;

  /// No description provided for @added.
  ///
  /// In fr, this message translates to:
  /// **'Ajouté'**
  String get added;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @clear_all.
  ///
  /// In fr, this message translates to:
  /// **'Effacer la liste'**
  String get clear_all;

  /// No description provided for @clear_all_confirmation_message.
  ///
  /// In fr, this message translates to:
  /// **'Cela supprimera définitivement tous les articles de votre liste.'**
  String get clear_all_confirmation_message;

  /// No description provided for @clear_all_confirmation_title.
  ///
  /// In fr, this message translates to:
  /// **'Effacer tous les articles ?'**
  String get clear_all_confirmation_title;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @coming_soon.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt disponible !'**
  String get coming_soon;

  /// No description provided for @copied.
  ///
  /// In fr, this message translates to:
  /// **'Copié dans le presse-papiers'**
  String get copied;

  /// No description provided for @dismiss.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get dismiss;

  /// No description provided for @edit_grocery.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get edit_grocery;

  /// No description provided for @empty_grocery_list.
  ///
  /// In fr, this message translates to:
  /// **'Votre liste est vide.\nAjoutez des articles en appuyant sur le bouton \"+\".'**
  String get empty_grocery_list;

  /// No description provided for @frequent_suggestions.
  ///
  /// In fr, this message translates to:
  /// **'Suggestions fréquentes'**
  String get frequent_suggestions;

  /// No description provided for @generic_error.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite. Veuillez réessayer plus tard.'**
  String get generic_error;

  /// No description provided for @item_edited.
  ///
  /// In fr, this message translates to:
  /// **'« {content} » modifié'**
  String item_edited(String content);

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

  /// No description provided for @mark_as_bought.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme acheté'**
  String get mark_as_bought;

  /// No description provided for @nearby_add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get nearby_add;

  /// No description provided for @nearby_connect.
  ///
  /// In fr, this message translates to:
  /// **'Connecter'**
  String get nearby_connect;

  /// No description provided for @nearby_connected.
  ///
  /// In fr, this message translates to:
  /// **'Connecté'**
  String get nearby_connected;

  /// No description provided for @nearby_connecting.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get nearby_connecting;

  /// No description provided for @nearby_connection_failed.
  ///
  /// In fr, this message translates to:
  /// **'Échec de connexion'**
  String get nearby_connection_failed;

  /// No description provided for @nearby_devices.
  ///
  /// In fr, this message translates to:
  /// **'Appareils à proximité ({count})'**
  String nearby_devices(int count);

  /// Nombre d'articles dans la liste de courses partagée.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{0 article} one{1 article} other{{count} articles}}'**
  String nearby_item_count(int count);

  /// No description provided for @nearby_items_added.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun nouvel article ajouté} one{1 article ajouté} other{{count} articles ajoutés}}'**
  String nearby_items_added(int count);

  /// No description provided for @nearby_list_received_message.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{La liste partagée est vide.} one{Ajouter 1 article à votre liste ?} other{Ajouter {count} articles à votre liste ?}}'**
  String nearby_list_received_message(int count);

  /// No description provided for @nearby_list_received_title.
  ///
  /// In fr, this message translates to:
  /// **'{name} a partagé une liste'**
  String nearby_list_received_title(String name);

  /// No description provided for @nearby_list_sent.
  ///
  /// In fr, this message translates to:
  /// **'Liste envoyée à {name}'**
  String nearby_list_sent(String name);

  /// No description provided for @nearby_my_list.
  ///
  /// In fr, this message translates to:
  /// **'Ma liste'**
  String get nearby_my_list;

  /// No description provided for @nearby_retry.
  ///
  /// In fr, this message translates to:
  /// **'Redémarrer le partage à proximité'**
  String get nearby_retry;

  /// No description provided for @nearby_retry_connection.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get nearby_retry_connection;

  /// No description provided for @nearby_searching.
  ///
  /// In fr, this message translates to:
  /// **'Recherche d\'appareils à proximité…'**
  String get nearby_searching;

  /// No description provided for @nearby_send_list.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer la liste'**
  String get nearby_send_list;

  /// No description provided for @nearby_share_grocery_list.
  ///
  /// In fr, this message translates to:
  /// **'Partager la liste de courses'**
  String get nearby_share_grocery_list;

  /// No description provided for @nearby_transfer_unavailable.
  ///
  /// In fr, this message translates to:
  /// **'Le transfert de liste n\'est pas encore disponible.'**
  String get nearby_transfer_unavailable;

  /// No description provided for @no_mail_app.
  ///
  /// In fr, this message translates to:
  /// **'Écrivez à {email}'**
  String no_mail_app(String email);

  /// No description provided for @product_name.
  ///
  /// In fr, this message translates to:
  /// **'Nom du produit'**
  String get product_name;

  /// No description provided for @quick_action_delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get quick_action_delete;

  /// No description provided for @quick_action_edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get quick_action_edit;

  /// No description provided for @quick_action_share.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get quick_action_share;

  /// No description provided for @settings_about_title.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get settings_about_title;

  /// No description provided for @settings_color_title.
  ///
  /// In fr, this message translates to:
  /// **'Style de couleur'**
  String get settings_color_title;

  /// No description provided for @settings_language_title.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settings_language_title;

  /// No description provided for @settings_preferences_title.
  ///
  /// In fr, this message translates to:
  /// **'Préférences'**
  String get settings_preferences_title;

  /// No description provided for @settings_report_issue.
  ///
  /// In fr, this message translates to:
  /// **'Signaler un problème'**
  String get settings_report_issue;

  /// No description provided for @settings_support_title.
  ///
  /// In fr, this message translates to:
  /// **'Assistance'**
  String get settings_support_title;

  /// No description provided for @settings_theme_color_amber.
  ///
  /// In fr, this message translates to:
  /// **'Ambre'**
  String get settings_theme_color_amber;

  /// No description provided for @settings_theme_color_blue.
  ///
  /// In fr, this message translates to:
  /// **'Bleu'**
  String get settings_theme_color_blue;

  /// No description provided for @settings_theme_color_blue_grey.
  ///
  /// In fr, this message translates to:
  /// **'Bleu gris'**
  String get settings_theme_color_blue_grey;

  /// No description provided for @settings_theme_color_brown.
  ///
  /// In fr, this message translates to:
  /// **'Marron'**
  String get settings_theme_color_brown;

  /// No description provided for @settings_theme_color_cyan.
  ///
  /// In fr, this message translates to:
  /// **'Cyan'**
  String get settings_theme_color_cyan;

  /// No description provided for @settings_theme_color_deep_orange.
  ///
  /// In fr, this message translates to:
  /// **'Orange foncé'**
  String get settings_theme_color_deep_orange;

  /// No description provided for @settings_theme_color_deep_purple.
  ///
  /// In fr, this message translates to:
  /// **'Violet foncé'**
  String get settings_theme_color_deep_purple;

  /// No description provided for @settings_theme_color_dynamic.
  ///
  /// In fr, this message translates to:
  /// **'Dynamique'**
  String get settings_theme_color_dynamic;

  /// No description provided for @settings_theme_color_green.
  ///
  /// In fr, this message translates to:
  /// **'Vert'**
  String get settings_theme_color_green;

  /// No description provided for @settings_theme_color_indigo.
  ///
  /// In fr, this message translates to:
  /// **'Indigo'**
  String get settings_theme_color_indigo;

  /// No description provided for @settings_theme_color_light_blue.
  ///
  /// In fr, this message translates to:
  /// **'Bleu clair'**
  String get settings_theme_color_light_blue;

  /// No description provided for @settings_theme_color_light_green.
  ///
  /// In fr, this message translates to:
  /// **'Vert clair'**
  String get settings_theme_color_light_green;

  /// No description provided for @settings_theme_color_lime.
  ///
  /// In fr, this message translates to:
  /// **'Citron vert'**
  String get settings_theme_color_lime;

  /// No description provided for @settings_theme_color_orange.
  ///
  /// In fr, this message translates to:
  /// **'Orange'**
  String get settings_theme_color_orange;

  /// No description provided for @settings_theme_color_pink.
  ///
  /// In fr, this message translates to:
  /// **'Rose'**
  String get settings_theme_color_pink;

  /// No description provided for @settings_theme_color_purple.
  ///
  /// In fr, this message translates to:
  /// **'Violet'**
  String get settings_theme_color_purple;

  /// No description provided for @settings_theme_color_red.
  ///
  /// In fr, this message translates to:
  /// **'Rouge'**
  String get settings_theme_color_red;

  /// No description provided for @settings_theme_color_teal.
  ///
  /// In fr, this message translates to:
  /// **'Sarcelle'**
  String get settings_theme_color_teal;

  /// No description provided for @settings_theme_color_yellow.
  ///
  /// In fr, this message translates to:
  /// **'Jaune'**
  String get settings_theme_color_yellow;

  /// No description provided for @settings_theme_title.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settings_theme_title;

  /// No description provided for @settings_title.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings_title;

  /// No description provided for @support_email_subject.
  ///
  /// In fr, this message translates to:
  /// **'Un problème avec FreshList'**
  String get support_email_subject;

  /// No description provided for @theme_mode_dark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get theme_mode_dark;

  /// No description provided for @theme_mode_light.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get theme_mode_light;

  /// No description provided for @theme_mode_system.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get theme_mode_system;
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
