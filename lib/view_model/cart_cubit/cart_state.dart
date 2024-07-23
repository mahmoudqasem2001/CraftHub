abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {}

class CartFailure extends CartState {
  final String error;
  CartFailure(this.error);
}
