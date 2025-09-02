import 'package:flutter/material.dart';
import 'package:sqflite_counter/src/features/items/controllers/items_controller.dart';

class ItemsView extends StatefulWidget {
  final ItemsController itemsController;

  const ItemsView({super.key, required this.itemsController});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  void initState() {
    super.initState();
    widget.itemsController.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Items'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () {
              widget.itemsController.clearAll();
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.itemsController,
        builder: (context, _) {
          final items = widget.itemsController.items;

          if (items.isEmpty) {
            return const Center(child: Text('The list is empty.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await widget.itemsController.loadItems();
            },
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${item.value}')),
                  title: Text('Created at: ${item.createdAt}'),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('addItemToList'),
            child: const Icon(Icons.add_outlined),
            onPressed: () {
              // exemplo: valor aleatório
              final value = DateTime.now().millisecondsSinceEpoch % 100;
              widget.itemsController.addItem(value);
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('removeItemFromList'),
            child: const Icon(Icons.remove_outlined),
            onPressed: () {
              final items = widget.itemsController.items;
              if (items.isNotEmpty) {
                widget.itemsController.removeItem(0); // remove o primeiro
              }
            },
          ),
        ],
      ),
    );
  }
}
