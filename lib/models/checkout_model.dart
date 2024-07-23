class Checkout {
  final String phoneNumber;
  final String shippingAddress;
  final int artistId;
  final List<CheckoutItem> items;

  Checkout({
    required this.phoneNumber,
    required this.shippingAddress,
    required this.artistId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'shipping_address': shippingAddress,
      'artist': artistId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CheckoutItem {
  final int itemId;
  final int itemQuantity;

  CheckoutItem({
    required this.itemId,
    required this.itemQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'item': itemId,
      'item_quantity': itemQuantity,
    };
  }
}
