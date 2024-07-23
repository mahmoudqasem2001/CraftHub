import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_services.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _categoryService;

  CategoryCubit(this._categoryService) : super(CategoryInitial());

  void loadApprovedCategories() async {
    try {
      final categories = await _categoryService.getApprovedCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }

  void addCategory(String name) async {
    try {
      final category = await _categoryService.addCategory(name);
      emit(CategoryAdded(category));
    } catch (e) {
      emit(CategoryError('Failed to add category: $e'));
    }
  }

  void loadInterestedCategoriesItems() async {
    try {
      final categoryItems =
          await _categoryService.getInterestedCategoriesItems();
      emit(InterestedCategoriesItemsLoaded(categoryItems));
    } catch (e) {
      emit(CategoryError('Failed to load interested categories items: $e'));
    }
  }

  void loadAllItemsOfCategory(int categoryId) async {
    try {
      final items = await _categoryService.getAllItemsOfCategory(categoryId);
      emit(AllItemsOfCategoryLoaded(items));
    } catch (e) {
      emit(CategoryError('Failed to load items of category $categoryId: $e'));
    }
  }
}
