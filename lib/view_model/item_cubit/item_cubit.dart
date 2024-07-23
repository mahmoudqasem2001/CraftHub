import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/item_services.dart';
import 'item_state.dart';
import '../../models/item_model.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitial());

  final ItemServices itemServices = ItemServicesImpl();

  List<Item> _items = [];

  Future<void> fetchItemsForArtist() async {
    emit(ItemLoading());
    try {
      final result = await itemServices.getItemsForArtist();

      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) {
          _items = r;
          return emit(ItemListSuccess(r));
        },
      );
    } catch (e) {
      //print(e.toString());

      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> createItemForArtist(Item item) async {
    emit(ItemLoading());
    try {
      final result = await itemServices.createItemForArtist(item);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) => emit(ItemCreateSuccess(r)),
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> fetchItemDetails(int id) async {
    emit(ItemLoading());
    try {
      final result = await itemServices.getItemDetails(id);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) => emit(ItemDetailsSuccess(r['item'], r['comments'])),
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> updateItemForArtist(
      int id, Map<String, dynamic> updatedData) async {
    emit(ItemLoading());
    try {
      final result =
          await itemServices.updateItemImageForArtist(id, updatedData);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) {
          fetchItemDetails(id);
        },
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> deleteItemForArtist(int id, int index) async {
    emit(ItemLoading());
    try {
      final result = await itemServices.deleteItemForArtist(id);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) {
          _items.removeAt(index);
          emit(ItemListSuccess(_items));
        },
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> fetchItemsForCustomerByArtist(int artistId) async {
    emit(ItemLoading());
    try {
      final result = await itemServices.getItemsForCustomerByArtist(artistId);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) => emit(ItemListSuccess(r)),
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }

  Future<void> fetchItemDetailsForCustomer(int itemId) async {
    emit(ItemLoading());
    try {
      final result = await itemServices.getItemDetailsForCustomer(itemId);
      result.fold(
        (l) => emit(ItemFailure(l.detail)),
        (r) => emit(ItemDetailsSuccess(r, [])),
      );
    } catch (e) {
      emit(ItemFailure(e.toString()));
    }
  }
}
