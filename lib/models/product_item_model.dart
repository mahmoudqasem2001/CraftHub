// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final String description;
  final double price;
  final String category;
  final double averageRate;
  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    required this.category,
    this.averageRate = 4.5,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    double? price,
    String? category,
    double? averageRate,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': imgUrl,
      'description': description,
      'price': price,
      'category': category,
      'averageRate': averageRate,
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'].toString(),
      name: map['name'] as String,
      imgUrl: map['image'] as String,
      description: map['description'] as String,
      price: double.parse(map['price']),
      category: map['category'].toString(),
      averageRate: map['averageRate'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductItemModel.fromJson(String source) =>
      ProductItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductItemModel(id: $id, name: $name, imgUrl: $imgUrl, description: $description, price: $price, category: $category, averageRate: $averageRate)';
  }

  @override
  bool operator ==(covariant ProductItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.description == description &&
        other.price == price &&
        other.category == category &&
        other.averageRate == averageRate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        description.hashCode ^
        price.hashCode ^
        category.hashCode ^
        averageRate.hashCode;
  }
}

List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: DateTime.now().toIso8601String(),
    name: 'Guitar',
    imgUrl:
        'https://images-platform.99static.com/Os4HAVSNiRc5bgHNAdHRqSZ6eaA=/0x0:2000x2000/500x500/top/smart/99designs-contests-attachments/123/123960/attachment_123960437',
    price: 30,
    category: 'Music',
  ),
  // ProductItemModel(
  //   id: DateTime.now().toIso8601String(),
  //   name: 'Football',
  //   imgUrl:
  //       'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Sport_balls.svg/640px-Sport_balls.svg.png',
  //   price: 10,
  //   category: 'Sport',
  // ),
  ProductItemModel(
    id: DateTime.now().toIso8601String(),
    name: 'Piano',
    imgUrl:
        'https://marketplace.canva.com/EAFMGBjrl5s/1/0/800w/canva-purple-minimalist-modern-music-instagram-post-4NArdlT765U.jpg',
    price: 10,
    category: 'Music',
  ),
  ProductItemModel(
    id: DateTime.now().toIso8601String(),
    name: 'Guitar',
    imgUrl:
        'https://images-platform.99static.com/Os4HAVSNiRc5bgHNAdHRqSZ6eaA=/0x0:2000x2000/500x500/top/smart/99designs-contests-attachments/123/123960/attachment_123960437',
    price: 30,
    category: 'Music',
  ),
  // ProductItemModel(
  //   id: DateTime.now().toIso8601String(),
  //   name: 'Cake',
  //   imgUrl:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9yBeXOSiR-9QJizu7DBzQT3cWMggVF3K7QfFJKbU68Q&s',
  //   price: 10,
  //   category: 'Cooking',
  // ),
  // ProductItemModel(
  //   id: DateTime.now().toIso8601String(),
  //   name: 'Sport Balls',
  //   imgUrl:
  //       'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Sport_balls.svg/640px-Sport_balls.svg.png',
  //   price: 10,
  //   category: 'Sport',
  // ),
  // ProductItemModel(
  //   id: DateTime.now().toIso8601String(),
  //   name: 'Sweet Shirt',
  //   imgUrl:
  //       'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
  //   price: 15,
  //   category: 'Clothes',
  // ),
];

List<ProductItemModel> dummyFavorites = [
  ProductItemModel(
    id: DateTime.now().toIso8601String(),
    name: 'T-shirt',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/07/Tshirtpng.parspng.com_.png',
    price: 10,
    category: 'Clothes',
  ),
];
