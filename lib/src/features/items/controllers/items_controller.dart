import 'package:flutter/material.dart';
import 'package:sqflite_counter/src/features/items/models/item_model.dart';
import 'package:sqflite_counter/src/features/items/repositories/items_repository.dart';

typedef _Controller = ChangeNotifier;

abstract class ItemsController extends _Controller {
  List<ItemModel> get items;

  Future<void> loadItems();
  Future<void> addItem(int value);
  Future<void> removeItem(int index);
  Future<void> clearAll();
}

class ItemsControllerImpl extends _Controller implements ItemsController {
  final ItemsRepository itemsRepository;

  ItemsControllerImpl({required this.itemsRepository});

  List<ItemModel> _items = [];

  @override
  List<ItemModel> get items => _items;

  @override
  Future<void> loadItems() async {
    _items = await itemsRepository.getAllItems();
    _emit(_items);
  }

  @override
  Future<void> addItem(int value) async {
    final newItem = ItemModel(value: value, createdAt: DateTime.now());

    await itemsRepository.insertItem(newItem);
    await loadItems();
  }

  @override
  Future<void> removeItem(int index) async {
    final item = _items[index];
    await itemsRepository.deleteItem(item);
    await loadItems();
  }

  @override
  Future<void> clearAll() async {
    await itemsRepository.clearAll();
    await loadItems();
  }

  void _emit(List<ItemModel> newValue) {
    _items = newValue;
    notifyListeners();
    debugPrint('ItemsController: $_items');
  }
}
