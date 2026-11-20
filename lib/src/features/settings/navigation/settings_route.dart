import 'package:flutter/widgets.dart';
import 'package:fresh_list/src/features/home/navigation/home_route.dart';
import 'package:fresh_list/src/features/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

class const SettingsRoute() extends GoRouteData with $SettingsRoute {
  static const path = 'settings';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsView();
}
