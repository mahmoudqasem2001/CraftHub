import '../../models/order_details_model.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderListSuccess extends OrderState {
  final List<OrderDetails> orders;
  OrderListSuccess(this.orders);
}

final class OrderDetailsSuccess extends OrderState {
  final OrderDetails orderDetails;
  OrderDetailsSuccess(this.orderDetails);
}

final class OrderFailure extends OrderState {
  final String message;
  OrderFailure(this.message);
}
