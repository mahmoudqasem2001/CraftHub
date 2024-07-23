// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'artist_profile_model.dart';

class Item {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  String name;
  double price;
  String description;
  int perItem;
  int countLikes;
  int countComments;
  int countOrders;
  String image;
  ArtistProfileModel profile;
  Item({
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
  });

  factory Item.newItem({
    required String name,
    required double price,
    required String description,
    required String image,
    required int perItem,
  }) {
    return Item(
        id: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: true,
        name: name,
        price: price,
        description: description,
        perItem: perItem,
        countLikes: 0,
        countComments: 0,
        countOrders: 0,
        image: image,
        profile:
            ArtistProfileModel(artistId: 0, artistName: '', ProjectName: ''));
  }

  Item copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? status,
    String? name,
    double? price,
    String? description,
    int? perItem,
    int? countLikes,
    int? countComments,
    int? countOrders,
    String? image,
    ArtistProfileModel? profile,
  }) {
    return Item(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      perItem: perItem ?? this.perItem,
      countLikes: countLikes ?? this.countLikes,
      countComments: countComments ?? this.countComments,
      countOrders: countOrders ?? this.countOrders,
      image: image ?? this.image,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'status': status,
      'name': name,
      'price': price,
      'description': description,
      'per_item': perItem,
      'count_likes': countLikes,
      'count_comments': countComments,
      'count_orders': countOrders,
      'image': image,
      'profile': profile,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      status: map['status'] as bool,
      name: map['name'] as String,
      price: double.parse(map['price']),
      description: map['description'] as String,
      perItem: map['per_item'] as int,
      countLikes: map['count_likes'] as int,
      countComments: map['count_comments'] as int,
      countOrders: map['count_orders'] as int,
      image: map['image'],
      profile: ArtistProfileModel(
        artistId: map['profile']['artist_id'],
        artistName: map['profile']['artist'],
        ProjectName: map['profile']['project_name'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, created_at: $createdAt, updated_at: $updatedAt, status: $status, name: $name, price: $price, description: $description, per_item: $perItem, count_likes: $countLikes, count_comments: $countComments, count_orders: $countOrders, image: $image, profile: $profile)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.status == status &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.perItem == perItem &&
        other.countLikes == countLikes &&
        other.countComments == countComments &&
        other.countOrders == countOrders &&
        other.image == image &&
        other.profile == profile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        status.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        perItem.hashCode ^
        countLikes.hashCode ^
        countComments.hashCode ^
        countOrders.hashCode ^
        image.hashCode ^
        profile.hashCode;
  }
}
