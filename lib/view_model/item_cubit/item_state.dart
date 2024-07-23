import '../../models/item_model.dart';

sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemListSuccess extends ItemState {
  final List<Item> items;

  ItemListSuccess(this.items);
}

final class ItemDetailsSuccess extends ItemState {
  final Item item;
  final List<Map<String, dynamic>> comments;
  ItemDetailsSuccess(
    this.item,
    this.comments,
  );
}

final class ItemCreateSuccess extends ItemState {
  final Item item;
  ItemCreateSuccess(this.item);
}

final class ItemUpdateSuccess extends ItemState {
  final Item item;
  ItemUpdateSuccess(this.item);
}

final class ItemDeleteSuccess extends ItemState {}

final class ItemFailure extends ItemState {
  final String message;
  ItemFailure(this.message);
}
