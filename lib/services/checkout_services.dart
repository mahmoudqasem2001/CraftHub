import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/models/checkout_model.dart';
import 'package:grad_new_project/models/order_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';

abstract class CheckoutServices {
  Future<Either<ErrorMessageModel, OrderModel>> checkoutOrder({
    required String phoneNumber,
    required String shippingAddress,
    required int artistId,
    required List<CheckoutItem> items,
  });
}

class CheckoutServicesImpl extends CheckoutServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, OrderModel>> checkoutOrder({
    required String phoneNumber,
    required String shippingAddress,
    required int artistId,
    required List<CheckoutItem> items,
  }) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}orders/checkout/"),
      method: 'POST',
      body: {
        "phone_number": phoneNumber,
        "shipping_address": shippingAddress,
        "artist": artistId.toString(),
        "items": items.map((item) => item.toJson()).toList(),
      },
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final OrderModel order = OrderModel.fromJson(responseData);
      return Right(order);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
