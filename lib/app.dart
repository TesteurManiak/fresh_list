import 'package:flutter/material.dart';
import 'package:todo_list/gen/app_localizations.dart';
import 'package:todo_list/src/core/consts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Consts.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
