import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/checkout_services.dart';
import 'checkout_state.dart';
import '../../models/checkout_model.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final CheckoutServices checkoutServices = CheckoutServicesImpl();

  Future<void> checkoutOrder({
    required String phoneNumber,
    required String shippingAddress,
    required int artistId,
    required List<CheckoutItem> items,
  }) async {
    emit(CheckoutLoading());
    try {
      final result = await checkoutServices.checkoutOrder(
        phoneNumber: phoneNumber,
        shippingAddress: shippingAddress,
        artistId: artistId,
        items: items,
      );
      result.fold(
        (l) => emit(CheckoutFailure(l.detail)),
        (r) => emit(CheckoutSuccess(r)),
      );
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }
}
