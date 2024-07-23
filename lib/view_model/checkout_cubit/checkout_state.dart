import '../../models/order_model.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutSuccess extends CheckoutState {
  final OrderModel order;
  CheckoutSuccess(this.order);
}

final class CheckoutFailure extends CheckoutState {
  final String message;
  CheckoutFailure(this.message);
}
