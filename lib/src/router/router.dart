import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/features/home/navigation/home_route.dart' as home;

final routerProvider = Provider.family<GoRouter, bool>((
  ref,
  debugLogDiagnostics,
) {
  return GoRouter(
    routes: [...home.$appRoutes],
    debugLogDiagnostics: debugLogDiagnostics,
  );
});
