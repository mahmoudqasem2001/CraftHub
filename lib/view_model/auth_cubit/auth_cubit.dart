import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/models/category_model.dart';

import '../../services/auth_services.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();
  List<CategoryModel> categories = [];

  Future<void> getCategories() async {
    emit(AuthLoading());
    categories = await authServices.getCategories();
    print('------ Get Categories For Register ------');
    emit(AuthInitial());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.signInWithEmailAndPassword(email, password);
      result.fold((l) => emit(AuthFailure(l.detail)), (isFinished) {
        if (isFinished) {
          emit(AuthSuccess());
        } else {
          emit(AuthIncompleteProfile());
        }
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpAsArtist(
      String firstName,
      String lastName,
      String email,
      String country,
      String state,
      String city,
      String projectName,
      String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.signUpAsArtist(firstName, lastName,
          email, country, state, city, projectName, password);
      result.fold(
          (l) => emit(AuthFailure(l.detail)), (r) => emit(AuthSuccess()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpAsUser(String firstName, String lastName, String email,
      String country, String state, String city, String password) async {
    try {
      final result = await authServices.signUpAsUser(
          firstName, lastName, email, country, state, city, password);
      result.fold(
          (l) => emit(AuthFailure(l.detail)), (r) => emit(AuthSuccess()));
    } catch (e) {
      print(e);
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> createProfile({
    required int gender,
    required String birthDate,
    required String? projectName,
    required String image,
    required Map<String, int> interestedCategories,
    String? newCategory,
  }) async {
    try {
      final result = await authServices.createProfile(
          gender: gender,
          birthDate: birthDate,
          image: image,
          interestedCategories: interestedCategories);
      result.fold(
          (l) => emit(AuthFailure(l.detail)), (r) => emit(AuthSuccess()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authServices.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Future<void> getCurrentUser() async {
  //   emit(AuthLoading());
  //   try {
  //     final user = await authServices.currentUser();
  //     if (user != null) {
  //       emit(AuthSuccess(user: user));
  //     } else {
  //       emit(AuthInitial());
  //     }
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
}
