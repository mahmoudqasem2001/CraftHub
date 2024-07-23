import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/announcement_model.dart';
import '../../models/category_model.dart';
import '../../models/product_item_model.dart';
import '../../services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    print('---------- create home block');
  }

  final homeServices = HomeServicesImpl();

  List<ProductItemModel> products = [];
  List<AnnouncementModel> announcement = [];
  List<CategoryModel> categories = [];
  List<Map<String, dynamic>> artists = [];
  List<Map<String, dynamic>> favorites = [];

  void getHomeData() async {
    emit(HomeLoading());
    try {
      products = await homeServices.getProducts();
      announcement = await homeServices.getAnnouncements();

      categories = await homeServices.getCategories();

      artists = await homeServices.getArtists();

      favorites = await homeServices.getFavorites();

      emit(
        HomeLoaded(
          artists: artists,
          products: products,
          announcement: announcement,
          categories: categories,
          favorites: favorites,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void removeItemFavorite(int index, int itemId, HomeLoaded? state) async {
    emit(HomeLoading());
    try {
      final bool remove = await homeServices.removeOrAddItemFavorite(itemId);

      final List<AnnouncementModel> announcement =
          await homeServices.getAnnouncements();

      if (remove) {
        favorites.removeAt(index);
      }

      emit(
        HomeLoaded(
          artists: artists,
          products: products,
          announcement: announcement,
          categories: categories,
          favorites: favorites,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void addItemFavorite(Map<String, dynamic> item, HomeLoaded? state) async {
    emit(HomeLoading());
    try {
      final dynamic add =
          await homeServices.removeOrAddItemFavorite(item['id']);

      final List<AnnouncementModel> announcement =
          await homeServices.getAnnouncements();

      if (add == true) {
        favorites.removeWhere((element) => element['item']['id'] == item['id']);
      } else if (add != false) {
        favorites.add(add);
      }

      emit(
        HomeLoaded(
          artists: artists,
          products: products,
          announcement: announcement,
          categories: categories,
          favorites: favorites,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
