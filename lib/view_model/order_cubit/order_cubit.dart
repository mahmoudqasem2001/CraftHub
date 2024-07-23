import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/order_services.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final OrderServices orderServices = OrderServicesImpl();

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      final result = await orderServices.getOrders();
      result.fold(
        (l) => emit(OrderFailure(l.detail)),
        (r) {
          return emit(OrderListSuccess(r));
        },
      );
    } catch (e) {
      print(e);
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> fetchOrderDetails(int pk) async {
    emit(OrderLoading());
    try {
      final result = await orderServices.getOrderDetails(pk);
      result.fold(
        (l) => emit(OrderFailure(l.detail)),
        (r) => emit(OrderDetailsSuccess(r)),
      );
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
