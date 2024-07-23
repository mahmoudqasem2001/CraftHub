class OrderModel {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  String orderModelStatus;
  double totalPrice;
  String phoneNumber;
  String shippingAddress;
  int customer;
  int artist;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.orderModelStatus,
    required this.totalPrice,
    required this.phoneNumber,
    required this.shippingAddress,
    required this.customer,
    required this.artist,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
      orderModelStatus: json['OrderModel_status'],
      totalPrice: json['total_price'].toDouble(),
      phoneNumber: json['phone_number'],
      shippingAddress: json['shipping_address'],
      customer: json['customer'],
      artist: json['artist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'OrderModel_status': orderModelStatus,
      'total_price': totalPrice,
      'phone_number': phoneNumber,
      'shipping_address': shippingAddress,
      'customer': customer,
      'artist': artist,
    };
  }
}
