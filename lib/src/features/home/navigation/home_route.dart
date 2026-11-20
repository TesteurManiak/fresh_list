import 'package:flutter/widgets.dart';
import 'package:fresh_list/src/features/home/home_view.dart';
import 'package:fresh_list/src/features/settings/navigation/settings_route.dart';
import 'package:go_router/go_router.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
  routes: [TypedGoRoute<SettingsRoute>(path: SettingsRoute.path)],
)
class const HomeRoute() extends GoRouteData with $HomeRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}
