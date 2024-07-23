// category_item_model.dart

import 'dart:convert';

class CategoryItemModel {
  final String categoryName;
  final List<ItemModel> items;

  CategoryItemModel({
    required this.categoryName,
    required this.items,
  });

  factory CategoryItemModel.fromMap(Map<String, dynamic> map) {
    List<ItemModel> items = <ItemModel>[];
    map.forEach((key, value) {
      if (key != 'categoryName') {
        items.add(ItemModel.fromMap(value));
      }
    });
    return CategoryItemModel(
      categoryName: map['categoryName'],
      items: items,
    );
  }

  factory CategoryItemModel.fromJson(String source) =>
      CategoryItemModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryItemModel(categoryName: $categoryName, items: $items)';
}

class ItemModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
}
