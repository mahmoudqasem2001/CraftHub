part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.artists,
    required this.products,
    required this.announcement,
    required this.categories,
    required this.favorites,
  });

  final List<ProductItemModel> products;
  final List<AnnouncementModel> announcement;
  final List<CategoryModel> categories;
  final List<Map<String, dynamic>> artists;
  final List<Map<String, dynamic>> favorites;
}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
