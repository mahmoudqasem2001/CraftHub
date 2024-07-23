import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Map<String, dynamic> orders = {
    'sub_orders': [],
  };
  double totalPrice = 0;

  void addToCart(Map<String, dynamic> item) async {
    emit(CartLoading());

    (orders['sub_orders'] as List).add(
      {
        'artist': item['profile']['artist_id'],
        'items': [
          {
            'item': item['id'],
            'item_details': {
              'name': item['name'],
              'image': item['image'],
              'price': item['price'],
            },
            'item_quantity': item['item_quantity'],
          }
        ],
      },
    );

    totalPrice =
        totalPrice + (double.parse(item['price']) * item['item_quantity']);

    emit(CartLoaded());
  }

  void removeOrder(int index) async {
    emit(CartLoading());

    (orders['sub_orders'] as List).removeAt(index);

    emit(CartLoaded());
  }

  void updateQuantity(int index, int quantity) async {
    emit(CartLoading());

    Map<String, dynamic> item =
        (orders['sub_orders'] as List)[index]['items'][0];

    totalPrice = totalPrice -
        (double.parse(item['item_details']['price'])) * item['item_quantity'];

    (orders['sub_orders'] as List)[index]['items'][0]['item_quantity'] =
        quantity;

    totalPrice =
        totalPrice + (double.parse(item['item_details']['price'])) * quantity;

    emit(CartLoaded());
  }

  void checkout() async {
    emit(CartLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print({
      "phone_number": "0512345678",
      "shipping_address": "Nablus, Center of city",
      "sub_orders": orders["sub_orders"],
    });

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}orders/checkout/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}",
      },
      body: jsonEncode({
        "phone_number": "0512345678",
        "shipping_address": "Nablus, Center of city",
        "sub_orders": orders["sub_orders"],
      }),
    );

    if (response.statusCode == 201) {
      orders = {'sub_orders': []};
      totalPrice = 0;

      emit(CartLoaded());
    } else {
      emit(CartFailure('error'));
    }
  }
}
