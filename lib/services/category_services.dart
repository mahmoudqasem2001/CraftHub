import 'dart:convert';
import 'package:grad_new_project/shared/constants.dart';
import 'package:http/http.dart' as http;

import '../models/category_item_model.dart';
import '../models/category_model.dart';

class CategoryService {
  final String baseUrl = Constants.baseUrl;
  final String accessToken;

  CategoryService(this.accessToken);

  Future<List<CategoryModel>> getApprovedCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<CategoryModel> categories =
          list.map((model) => CategoryModel.fromMap(model)).toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<CategoryModel> addCategory(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories/new/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({'name': name}),
    );

    if (response.statusCode == 200) {
      return CategoryModel.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to add category');
    }
  }

  Future<Map<String, List<ItemModel>>> getInterestedCategoriesItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/interested/items/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, List<ItemModel>> categoryItems = {};
      Map<String, dynamic> jsonMap = json.decode(response.body);
      jsonMap.forEach((key, value) {
        List<ItemModel> items =
            (value as List).map((e) => ItemModel.fromMap(e)).toList();
        categoryItems[key] = items;
      });
      return categoryItems;
    } else {
      throw Exception('Failed to load interested categories items');
    }
  }

  Future<List<ItemModel>> getAllItemsOfCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/$categoryId/items/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<ItemModel> items =
          list.map((model) => ItemModel.fromMap(model)).toList();
      return items;
    } else {
      throw Exception('Failed to load items of category $categoryId');
    }
  }
}
