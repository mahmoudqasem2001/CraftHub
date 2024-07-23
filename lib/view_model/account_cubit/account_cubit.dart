import 'package:bloc/bloc.dart';
import 'package:grad_new_project/models/account_model.dart';
import 'package:grad_new_project/models/order_details_model.dart';
import 'package:grad_new_project/services/account_services.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountServices accountServices;

  AccountCubit(this.accountServices) : super(AccountInitial());

  final List<OrderDetails> orders = [];

  Future<void> fetchArtistAccountInfo() async {
    try {
      emit(AccountLoading());
      final account = await accountServices.fetchArtistAccountInfo();
      emit(AccountLoaded(account));
    } catch (e) {
      emit(AccountFailure('Failed to load artist account information'));
    }
  }

  Future<void> updateArtistAccountInfo(
      Map<String, dynamic> updatedFields) async {
    try {
      emit(AccountLoading());
      final updatedAccount =
          await accountServices.updateArtistAccountInfo(updatedFields);
      emit(AccountUpdated(updatedAccount));
    } catch (e) {
      emit(AccountFailure('Failed to update artist account information'));
    }
  }

  Future<void> fetchCustomerAccountInfo() async {
    try {
      emit(AccountLoading());
      final account = await accountServices.fetchCustomerAccountInfo();
      emit(AccountLoaded(account));
    } catch (e) {
      emit(AccountFailure('Failed to load customer account information'));
    }
  }

  Future<void> updateCustomerAccountInfo(
      Map<String, dynamic> updatedFields) async {
    try {
      emit(AccountLoading());
      final updatedAccount =
          await accountServices.updateCustomerAccountInfo(updatedFields);
      emit(AccountUpdated(updatedAccount));
    } catch (e) {
      emit(AccountFailure('Failed to update customer account information'));
    }
  }

  Future<void> fetchArtistItems(int artistId) async {
    try {
      emit(AccountLoading());
      final items = await accountServices.getArtistInfo(artistId);
      emit(ArtistItemsLoaded(items));
    } catch (e) {
      emit(AccountFailure('Failed to load items for artist: ${e.toString()}'));
    }
  }

  // Update Profile Information
  Future<void> updateProfileInfo(Map<String, dynamic> updatedFields) async {
    try {
      emit(AccountLoading());

      final currentAccount = await accountServices.fetchArtistAccountInfo();

      final updatedProfile =
          await accountServices.updateProfileInfo(updatedFields);

      final updatedAccount = AccountModel(
        id: currentAccount.id,
        firstName: currentAccount.firstName,
        lastName: currentAccount.lastName,
        email: currentAccount.email,
        country: currentAccount.country,
        state: currentAccount.state,
        city: currentAccount.city,
        profile: updatedProfile,
        followersCount: currentAccount.followersCount,
      );

      emit(AccountUpdated(updatedAccount));
    } catch (e) {
      emit(AccountFailure('Failed to update profile information'));
    }
  }
}
