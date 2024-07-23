class Comment {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  int item;
  User user;
  String comment;

  Comment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.item,
    required this.user,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
      item: json['item'],
      user: User.fromJson(json['user']),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'item': item,
      'user': user.toJson(),
      'comment': comment,
    };
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'image': image,
    };
  }
}
