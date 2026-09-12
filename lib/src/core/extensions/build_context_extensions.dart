import 'package:flutter/widgets.dart';
import 'package:todo_list/l10n/gen/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this);
}
