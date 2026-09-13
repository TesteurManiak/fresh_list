import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/features/home/navigation/home_route.dart';
import 'package:todo_list/src/features/settings/settings_view.dart';

class const SettingsRoute() extends GoRouteData with $SettingsRoute {
  static const path = 'settings';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsView();
}
