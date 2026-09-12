import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/features/home/home_view.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class const HomeRoute() extends GoRouteData with $HomeRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeView();
  }
}
