import 'package:go_router/go_router.dart';
import 'package:sqflite_counter/src/common/dependency_injectors/dependency_injector.dart';
import 'package:sqflite_counter/src/features/items/controllers/items_controller.dart';
import 'package:sqflite_counter/src/features/items/views/items_view.dart';

class ItemsRoutes {
  static String get items => '/items';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: items,
      builder: (context, state) {
        return ItemsView(itemsController: locator<ItemsController>());
      },
    ),
  ];
}
