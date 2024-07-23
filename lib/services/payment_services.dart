import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:grad_new_project/services/auth_services.dart';

import '../core/network/error_message_model.dart';
import '../models/payment_model.dart';
import '../shared/constants.dart';

abstract class PaymentServices {
  Future<Either<ErrorMessageModel, Payment>> addPaymentInfo({
    required String bankName,
    required String accountNumber,
    required String currency,
  });

  Future<Either<ErrorMessageModel, Payment>> getOrUpdatePaymentInfo({
    String? bankName,
    String? accountNumber,
    String? currency,
  });
}

class PaymentServicesImpl extends PaymentServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, Payment>> addPaymentInfo({
    required String bankName,
    required String accountNumber,
    required String currency,
  }) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}auth/payment/add/"),
      method: 'POST',
      body: {
        "bank_name": bankName,
        "account_number": accountNumber,
        "currency": currency,
      },
    );

    if (response.statusCode == 201) {
      final Payment payment = Payment.fromJson(jsonDecode(response.body));
      return Right(payment);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, Payment>> getOrUpdatePaymentInfo({
    String? bankName,
    String? accountNumber,
    String? currency,
  }) async {
    Map<String, dynamic> requestBody = {};

    if (bankName != null) requestBody['bank_name'] = bankName;
    if (accountNumber != null) requestBody['account_number'] = accountNumber;
    if (currency != null) requestBody['currency'] = currency;

    String method = requestBody.isEmpty ? 'GET' : 'PATCH';

    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}auth/payment/information/"),
      method: method,
      body: method == 'PATCH' ? requestBody : null,
    );

    if (response.statusCode == 200) {
      final Payment payment = Payment.fromJson(jsonDecode(response.body));
      return Right(payment);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
