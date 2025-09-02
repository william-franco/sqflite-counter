class ItemModel {
  final int? id;
  final int value;
  final DateTime createdAt;

  ItemModel({this.id, required this.value, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {'id': id, 'value': value, 'createdAt': createdAt.toIso8601String()};
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int?,
      value: map['value'] as int,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
