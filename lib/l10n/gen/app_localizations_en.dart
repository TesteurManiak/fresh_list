// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add_grocery => 'Add to the list';

  @override
  String get added => 'Added';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear_all => 'Clear all';

  @override
  String get clear_all_confirmation_message =>
      'This will permanently delete all items in your grocery list.';

  @override
  String get clear_all_confirmation_title => 'Clear all items?';

  @override
  String get close => 'Close';

  @override
  String get coming_soon => 'Coming soon — stay tuned!';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get edit_grocery => 'Edit grocery';

  @override
  String get empty_grocery_list =>
      'Your grocery list is empty.\nAdd items by clicking the \"+\" button.';

  @override
  String get frequent_suggestions => 'Frequent suggestions';

  @override
  String get generic_error => 'An error occurred. Please try again later.';

  @override
  String get language_en => 'English';

  @override
  String get language_fr => 'French';

  @override
  String get mark_as_bought => 'Mark as bought';

  @override
  String get nearby_advertise => 'Find Devices';

  @override
  String get nearby_connect => 'Connect';

  @override
  String get nearby_connected => 'Connected';

  @override
  String get nearby_connection_failed => 'Connection failed';

  @override
  String get nearby_connecting => 'Connecting';

  @override
  String nearby_devices(int count) {
    return 'Nearby devices ($count)';
  }

  @override
  String get nearby_discover => 'Be Discoverable';

  @override
  String nearby_item_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: '0 item',
    );
    return '$_temp0';
  }

  @override
  String get nearby_my_list => 'My list';

  @override
  String get nearby_retry => 'Restart nearby sharing';

  @override
  String get nearby_retry_connection => 'Retry';

  @override
  String get nearby_searching => 'Looking for nearby devices…';

  @override
  String get nearby_share_grocery_list => 'Share Grocery List';

  @override
  String get nearby_transfer_unavailable =>
      'List transfer is not available yet.';

  @override
  String get product_name => 'Product name';

  @override
  String get quick_action_delete => 'Delete';

  @override
  String get quick_action_edit => 'Edit';

  @override
  String get quick_action_share => 'Share';

  @override
  String get settings_about_title => 'About';

  @override
  String get settings_language_title => 'Language';

  @override
  String get settings_preferences_title => 'Preferences';

  @override
  String get settings_report_issue => 'Report an issue';

  @override
  String get settings_support_title => 'Support';

  @override
  String get settings_theme_title => 'Theme';

  @override
  String get settings_title => 'Settings';

  @override
  String get support_email_subject => 'Something wrong with FreshList';

  @override
  String get theme_mode_dark => 'Dark';

  @override
  String get theme_mode_light => 'Light';

  @override
  String get theme_mode_system => 'System';
}
