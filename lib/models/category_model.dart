// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String id;
  final String name;
  final String imgUrl;
  final List<Map<String, dynamic>>? items;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.items,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    List<Map<String, dynamic>>? items,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': imgUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      imgUrl: map['image'].toString(),
      items: map['items'] == null
          ? []
          : [...(map['items'] as List).map((e) => e as Map<String, dynamic>)],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductItemModel(id: $id, name: $name, imgUrl: $imgUrl)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.imgUrl == imgUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ imgUrl.hashCode;
  }
}

List<CategoryModel> categories = [
  CategoryModel(
    id: '1',
    name: 'Events Candy Giveaways',
    imgUrl: 'assets\\images\\categories\\1.jpg',
  ),
  CategoryModel(
    id: '2',
    name: 'Heritage and Embroidery',
    imgUrl: 'assets\\images\\categories\\2.jpg',
  ),
  CategoryModel(
    id: '3',
    name: 'Resin Crafts',
    imgUrl: 'assets\\images\\categories\\3.jpg',
  ),
  /*
  CategoryModel(
    id: '4',
    name: 'Refractory Clay Accessories',
    imgUrl: 'assets\\images\\categories\\4.jpg',
  ),*/
  CategoryModel(
    id: '4',
    name: 'Pottery',
    imgUrl: 'assets\\images\\categories\\15.jpg',
  ),
  CategoryModel(
    id: '5',
    name: 'Beads Handmades',
    imgUrl: 'assets\\images\\categories\\5.png',
  ),
  CategoryModel(
    id: '6',
    name: 'Sewing Clothes',
    imgUrl: 'assets\\images\\categories\\6.png',
  ),
  CategoryModel(
    id: '7',
    name: 'Drawing',
    imgUrl: 'assets\\images\\categories\\7.png',
  ),
  CategoryModel(
    id: '8',
    name: 'Handmade Notebooks',
    imgUrl: 'assets\\images\\categories\\8.png',
  ),
  CategoryModel(
    id: '9',
    name: 'Interactive Paper Games',
    imgUrl: 'assets\\images\\categories\\9.png',
  ),
  CategoryModel(
    id: '10',
    name: 'Wool Dolls',
    imgUrl: 'assets\\images\\categories\\10.png',
  ),
  CategoryModel(
    id: '11',
    name: 'Handmade Furniture',
    imgUrl: 'assets\\images\\categories\\11.jpg',
  ),
  CategoryModel(
    id: '12',
    name: 'Wood Carving',
    imgUrl: 'assets\\images\\categories\\12.jpg',
  ),
  CategoryModel(
    id: '13',
    name: 'Handmade Accessories',
    imgUrl: 'assets\\images\\categories\\13.png',
  ),
  CategoryModel(
    id: '14',
    name: 'Handmade Candles',
    imgUrl: 'assets\\images\\categories\\14.png',
  ),
];
/*
List<ProductItemModel> dummyFavorites = [
  ProductItemModel(
    id: DateTime.now().toIso8601String(),
    name: 'T-shirt',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/07/Tshirtpng.parspng.com_.png',
    price: 10,
    category: 'Clothes',
  ),
];*/
