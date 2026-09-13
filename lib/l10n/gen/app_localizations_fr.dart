// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get generic_error =>
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';

  @override
  String get close => 'Fermer';

  @override
  String get empty_grocery_list =>
      'Votre liste est vide.\nAjoutez des articles en appuyant sur le bouton \"+\".';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get quick_action_share => 'Partager';

  @override
  String get quick_action_edit => 'Modifier';

  @override
  String get quick_action_delete => 'Supprimer';

  @override
  String get add_grocery => 'Ajouter à la liste';

  @override
  String get edit_grocery => 'Modifier l\'entrée';

  @override
  String get mark_as_bought => 'Marquer comme acheté';

  @override
  String get product_name => 'Nom du produit';

  @override
  String get frequent_suggestions => 'Suggestions fréquentes';
}
