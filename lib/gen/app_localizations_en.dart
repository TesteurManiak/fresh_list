import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generic_error => 'An error occurred. Please try again later.';

  @override
  String get empty_grocery_list => 'Your grocery list is empty.\nAdd items by clicking the \"+\" button.';

  @override
  String get settings_title => 'Settings';

  @override
  String get quick_action_edit => 'Edit';

  @override
  String get quick_action_delete => 'Delete';

  @override
  String get add_grocery => 'Add grocery';

  @override
  String get mark_as_bought => 'Mark as bought';

  @override
  String get product_name => 'Product name';
}
