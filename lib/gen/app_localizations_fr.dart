import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get generic_error => 'Une erreur s\'est produite. Veuillez réessayer plus tard.';

  @override
  String get empty_grocery_list => 'Votre liste est vide. Ajoutez des articles en appuyant sur le bouton + ci-dessus.';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get quick_action_edit => 'Modifier';

  @override
  String get quick_action_delete => 'Supprimer';

  @override
  String get add_grocery => 'Ajouter un article';

  @override
  String get mark_as_bought => 'Marquer comme acheté';
}
