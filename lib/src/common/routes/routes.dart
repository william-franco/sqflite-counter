import 'package:go_router/go_router.dart';
import 'package:sqflite_counter/src/features/items/routes/items_routes.dart';

class Routes {
  static String get home => ItemsRoutes.items;

  GoRouter get routes => _routes;

  final GoRouter _routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [...ItemsRoutes().routes],
  );
}
