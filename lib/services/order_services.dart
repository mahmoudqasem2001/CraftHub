import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/models/order_details_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderServices {
  Future<Either<ErrorMessageModel, List<OrderDetails>>> getOrders();
  Future<Either<ErrorMessageModel, OrderDetails>> getOrderDetails(int pk);
}

class OrderServicesImpl extends OrderServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, List<OrderDetails>>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}orders/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}"
      },
    );

    if (response.statusCode == 200) {
      final List<OrderDetails> orders = [];
      final List<dynamic> responseData = jsonDecode(response.body);
      for (dynamic element in responseData) {
        orders.add(OrderDetails.fromJson((element as Map<String, dynamic>)));
      }
      return Right(orders);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, OrderDetails>> getOrderDetails(
      int pk) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}orders/$pk/details/"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final OrderDetails orderDetails = OrderDetails.fromJson(responseData);
      return Right(orderDetails);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
