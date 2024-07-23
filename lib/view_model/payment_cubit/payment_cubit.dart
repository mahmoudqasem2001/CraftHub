import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/payment_services.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentServices paymentServices;

  PaymentCubit(this.paymentServices) : super(PaymentInitial());

  Future<void> addPaymentInfo({
    required String bankName,
    required String accountNumber,
    required String currency,
  }) async {
    emit(PaymentLoading());
    try {
      final result = await paymentServices.addPaymentInfo(
        bankName: bankName,
        accountNumber: accountNumber,
        currency: currency,
      );
      result.fold(
        (failure) => emit(PaymentFailure(failure.detail)),
        (payment) => emit(PaymentAddSuccess(payment)),
      );
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  Future<void> getOrUpdatePaymentInfo({
    String? bankName,
    String? accountNumber,
    String? currency,
  }) async {
    emit(PaymentLoading());
    try {
      final result = await paymentServices.getOrUpdatePaymentInfo(
        bankName: bankName,
        accountNumber: accountNumber,
        currency: currency,
      );
      result.fold(
        (failure) => emit(PaymentFailure(failure.detail)),
        (payment) => emit(PaymentFetchOrUpdateSuccess(payment)),
      );
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
