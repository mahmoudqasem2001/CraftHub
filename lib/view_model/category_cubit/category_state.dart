import 'package:grad_new_project/models/category_item_model.dart';
import 'package:grad_new_project/models/category_model.dart';

abstract class CategoryEvent {}

class LoadApprovedCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final String name;

  AddCategory(this.name);
}

class LoadInterestedCategoriesItems extends CategoryEvent {}

class LoadAllItemsOfCategory extends CategoryEvent {
  final int categoryId;

  LoadAllItemsOfCategory(this.categoryId);
}

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<CategoryModel> categories;

  CategoriesLoaded(this.categories);
}

class CategoryAdded extends CategoryState {
  final CategoryModel category;

  CategoryAdded(this.category);
}

class InterestedCategoriesItemsLoaded extends CategoryState {
  final Map<String, List<ItemModel>> categoryItems;

  InterestedCategoriesItemsLoaded(this.categoryItems);
}

class AllItemsOfCategoryLoaded extends CategoryState {
  final List<ItemModel> categoryItems;

  AllItemsOfCategoryLoaded(this.categoryItems);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
