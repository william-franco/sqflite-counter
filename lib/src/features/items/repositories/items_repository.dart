import 'package:sqflite_counter/src/common/services/database_service.dart';
import 'package:sqflite_counter/src/features/items/models/item_model.dart';

abstract class ItemsRepository {
  Future<List<ItemModel>> getAllItems();
  Future<int> insertItem(ItemModel item);
  Future<int> deleteItem(ItemModel item);
  Future<int> clearAll();
}

class ItemsRepositoryImpl implements ItemsRepository {
  final DatabaseService databaseService;

  ItemsRepositoryImpl({required this.databaseService});

  @override
  Future<List<ItemModel>> getAllItems() async {
    final db = await databaseService.database;
    final result = await db.query('items', orderBy: 'createdAt DESC');
    return result.map((e) => ItemModel.fromMap(e)).toList();
  }

  @override
  Future<int> insertItem(ItemModel item) async {
    final db = await databaseService.database;
    return await db.insert('items', item.toMap());
  }

  @override
  Future<int> deleteItem(ItemModel item) async {
    final db = await databaseService.database;
    return await db.delete('items', where: 'id = ?', whereArgs: [item.id]);
  }

  @override
  Future<int> clearAll() async {
    final db = await databaseService.database;
    return await db.delete('items');
  }
}
