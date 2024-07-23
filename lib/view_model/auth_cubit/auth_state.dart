sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess();
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthIncompleteProfile extends AuthState {}
