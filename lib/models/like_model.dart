class Like {
  int item;
  int user;
  DateTime createdAt;

  Like({
    required this.item,
    required this.user,
    required this.createdAt,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      item: json['item'],
      user: json['user'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'user': user,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
