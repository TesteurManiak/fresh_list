// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get add_grocery => 'Ajouter à la liste';

  @override
  String get added => 'Ajouté';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear_all => 'Effacer la liste';

  @override
  String get clear_all_confirmation_message =>
      'Cela supprimera définitivement tous les articles de votre liste.';

  @override
  String get clear_all_confirmation_title => 'Effacer tous les articles ?';

  @override
  String get close => 'Fermer';

  @override
  String get coming_soon => 'Bientôt disponible !';

  @override
  String get copied => 'Copié dans le presse-papiers';

  @override
  String get dismiss => 'Fermer';

  @override
  String get edit_grocery => 'Modifier l\'entrée';

  @override
  String get empty_grocery_list =>
      'Votre liste est vide.\nAjoutez des articles en appuyant sur le bouton \"+\".';

  @override
  String get frequent_suggestions => 'Suggestions fréquentes';

  @override
  String get generic_error =>
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';

  @override
  String get language_en => 'Anglais';

  @override
  String get language_fr => 'Français';

  @override
  String get mark_as_bought => 'Marquer comme acheté';

  @override
  String get nearby_add => 'Ajouter';

  @override
  String get nearby_connect => 'Connecter';

  @override
  String get nearby_connected => 'Connecté';

  @override
  String get nearby_connecting => 'Connexion';

  @override
  String get nearby_connection_failed => 'Échec de connexion';

  @override
  String nearby_devices(int count) {
    return 'Appareils à proximité ($count)';
  }

  @override
  String nearby_item_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
      zero: '0 article',
    );
    return '$_temp0';
  }

  @override
  String nearby_items_added(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles ajoutés',
      one: '1 article ajouté',
      zero: 'Aucun nouvel article ajouté',
    );
    return '$_temp0';
  }

  @override
  String nearby_list_received_message(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ajouter $count articles à votre liste ?',
      one: 'Ajouter 1 article à votre liste ?',
      zero: 'La liste partagée est vide.',
    );
    return '$_temp0';
  }

  @override
  String nearby_list_received_title(String name) {
    return '$name a partagé une liste';
  }

  @override
  String nearby_list_sent(String name) {
    return 'Liste envoyée à $name';
  }

  @override
  String get nearby_my_list => 'Ma liste';

  @override
  String get nearby_retry => 'Redémarrer le partage à proximité';

  @override
  String get nearby_retry_connection => 'Réessayer';

  @override
  String get nearby_searching => 'Recherche d\'appareils à proximité…';

  @override
  String get nearby_send_list => 'Envoyer la liste';

  @override
  String get nearby_share_grocery_list => 'Partager la liste de courses';

  @override
  String get nearby_transfer_unavailable =>
      'Le transfert de liste n\'est pas encore disponible.';

  @override
  String get product_name => 'Nom du produit';

  @override
  String get quick_action_delete => 'Supprimer';

  @override
  String get quick_action_edit => 'Modifier';

  @override
  String get quick_action_share => 'Partager';

  @override
  String get settings_about_title => 'À propos';

  @override
  String get settings_language_title => 'Langue';

  @override
  String get settings_preferences_title => 'Préférences';

  @override
  String get settings_report_issue => 'Signaler un problème';

  @override
  String get settings_support_title => 'Assistance';

  @override
  String get settings_theme_title => 'Thème';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get support_email_subject => 'Un problème avec FreshList';

  @override
  String get theme_mode_dark => 'Sombre';

  @override
  String get theme_mode_light => 'Clair';

  @override
  String get theme_mode_system => 'Système';
}
