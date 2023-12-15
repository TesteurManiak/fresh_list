import 'package:flutter/material.dart';
import 'package:todo_list/gen/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this);
}
