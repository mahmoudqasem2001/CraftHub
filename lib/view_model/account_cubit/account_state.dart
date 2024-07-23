// account_state.dart
import '../../models/account_model.dart';
import '../../models/item_model.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountModel account;
  AccountLoaded(this.account);
}

class AccountUpdated extends AccountState {
  final AccountModel account;

  AccountUpdated(this.account);
}

class ArtistItemsLoaded extends AccountState {
  final List<Item> items;

  ArtistItemsLoaded(this.items);
}

class AccountFailure extends AccountState {
  final String error;
  AccountFailure(this.error);
}
