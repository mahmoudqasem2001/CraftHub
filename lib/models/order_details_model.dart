import 'package:grad_new_project/models/profile_model.dart';

import 'order_item_model.dart';
import 'dart:convert';

class OrderDetails {
  final int id;
  final String customerName;
  final String shippingAddress;
  final String phoneNumber;
  final String email;
  String orderStatus;
  String totalPrice;
  final List<OrderItem> items;

  OrderDetails({
    required this.id,
    required this.customerName,
    required this.shippingAddress,
    required this.phoneNumber,
    required this.email,
    this.orderStatus = 'pending',
    this.totalPrice = '0',
    required this.items,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;

    List<OrderItem> itemList = itemsList
        .map((i) => OrderItem.fromJson(i as Map<String, dynamic>))
        .toList();

    return OrderDetails(
      id: json['id'],
      customerName: json['customer'],
      shippingAddress: json['shipping_address'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      items: itemList,
      totalPrice: json['total_price'],
      orderStatus: json['order_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'shipping_address': shippingAddress,
      'phone_number': phoneNumber,
      'email': email,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  int id;
  List<ItemElement> items;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  String totalPrice;
  String orderStatus;
  int artist;
  String customer;
  String email;
  String phoneNumber;
  String shippingAddress;

  OrderDetailsModel({
    required this.id,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.totalPrice,
    required this.orderStatus,
    required this.artist,
    required this.customer,
    required this.email,
    required this.phoneNumber,
    required this.shippingAddress,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        items: List<ItemElement>.from(
            json["items"].map((x) => ItemElement.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        totalPrice: json["total_price"],
        orderStatus: json["order_status"],
        artist: json["artist"],
        customer: json["customer"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        shippingAddress: json["shipping_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "total_price": totalPrice,
        "order_status": orderStatus,
        "artist": artist,
        "customer": customer,
        "email": email,
        "phone_number": phoneNumber,
        "shipping_address": shippingAddress,
      };
}

class ItemElement {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  int itemQuantity;
  int subOrder;
  ItemItem item;

  ItemElement({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.itemQuantity,
    required this.subOrder,
    required this.item,
  });

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        itemQuantity: json["item_quantity"],
        subOrder: json["sub_order"],
        item: ItemItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "item_quantity": itemQuantity,
        "sub_order": subOrder,
        "item": item.toJson(),
      };
}

class ItemItem {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  String name;
  String price;
  String description;
  int perItem;
  int countLikes;
  int countComments;
  int countOrders;
  String image;
  Profile profile;
  int category;

  ItemItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.name,
    required this.price,
    required this.description,
    required this.perItem,
    required this.countLikes,
    required this.countComments,
    required this.countOrders,
    required this.image,
    required this.profile,
    required this.category,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        perItem: json["per_item"],
        countLikes: json["count_likes"],
        countComments: json["count_comments"],
        countOrders: json["count_orders"],
        image: json["image"],
        profile: Profile.fromJson(json["profile"]),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "name": name,
        "price": price,
        "description": description,
        "per_item": perItem,
        "count_likes": countLikes,
        "count_comments": countComments,
        "count_orders": countOrders,
        "image": image,
        "profile": profile.toJson(),
        "category": category,
      };
}
