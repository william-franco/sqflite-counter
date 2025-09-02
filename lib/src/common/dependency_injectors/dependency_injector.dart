import 'package:get_it/get_it.dart';
import 'package:sqflite_counter/src/common/services/database_service.dart';
import 'package:sqflite_counter/src/features/items/controllers/items_controller.dart';
import 'package:sqflite_counter/src/features/items/repositories/items_repository.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startDatabaseServiceService();
  _startFeatureItems();
}

void _startDatabaseServiceService() {
  locator.registerLazySingleton<DatabaseService>(() => DatabaseServiceImpl());
}

void _startFeatureItems() {
  locator.registerCachedFactory<ItemsRepository>(
    () => ItemsRepositoryImpl(databaseService: locator<DatabaseService>()),
  );
  locator.registerCachedFactory<ItemsController>(
    () => ItemsControllerImpl(itemsRepository: locator<ItemsRepository>()),
  );
}

Future<void> initDependencies() async {
  await locator<DatabaseService>().initDatabase();
  // await Future.wait([locator<SettingController>().loadTheme()]);
}

void resetDependencies() {
  locator.reset();
}

// void resetFeatureSetting() {
//   locator.unregister<SettingRepository>();
//   locator.unregister<SettingController>();
//   _startFeatureSetting();
// }
