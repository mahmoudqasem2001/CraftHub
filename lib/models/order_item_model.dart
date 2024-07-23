import 'package:grad_new_project/models/item_model.dart';

class OrderItem {
  int id;
  Item item;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  int itemQuantity;
  int order;

  OrderItem({
    required this.id,
    required this.item,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.itemQuantity,
    required this.order,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      item: Item.fromMap(json['item']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
      itemQuantity: json['item_quantity'],
      order: json['sub_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'item_quantity': itemQuantity,
      'sub_order': order,
    };
  }
}
