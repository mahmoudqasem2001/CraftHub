import 'package:equatable/equatable.dart';

import '../../models/payment_model.dart'; // Ensure this model is created

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentAddSuccess extends PaymentState {
  final Payment payment;

  PaymentAddSuccess(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentFetchOrUpdateSuccess extends PaymentState {
  final Payment payment;

  PaymentFetchOrUpdateSuccess(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentFailure extends PaymentState {
  final String error;

  PaymentFailure(this.error);

  @override
  List<Object?> get props => [error];
}
