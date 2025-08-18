import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list/src/features/home/navigation/home_route.dart' as home;

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref, {required bool debugLogDiagnostics}) {
  return GoRouter(
    routes: [...home.$appRoutes],
    debugLogDiagnostics: debugLogDiagnostics,
  );
}
