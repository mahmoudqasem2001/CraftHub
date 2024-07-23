import 'dart:convert';

import 'package:grad_new_project/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/announcement_model.dart';
import '../models/category_model.dart';
import '../models/product_item_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<List<CategoryModel>> getCategories();
  Future<List<Map<String, dynamic>>> getArtists();
  Future<List<Map<String, dynamic>>> getFavorites();
  Future<dynamic> removeOrAddItemFavorite(int itemId);
}

class HomeServicesImpl implements HomeServices {
  @override
  Future<List<AnnouncementModel>> getAnnouncements() {
    return Future(() => dummyAnnouncements);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}categories/"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print('------------' + response.body);
    if (response.statusCode == 200) {
      List<CategoryModel> categories = [];
      for (Map<String, dynamic> element in jsonDecode(response.body) as List) {
        categories.add(CategoryModel.fromMap(element));
      }
      // print(categories.first.items);
      return Future(() => categories);
    }

    return Future(() => []);
  }

  @override
  Future<List<Map<String, dynamic>>> getArtists() async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}follow-ups/artists/items/"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> items = [];

      for (Map<String, dynamic> element
          in jsonDecode(response.body) as List<dynamic>) {
        items.add((element));
      }

      return Future(() => items);
    }

    return Future(() => []);
  }

  @override
  Future<List<ProductItemModel>> getProducts() async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}items/"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<ProductItemModel> items = [];
      for (Map<String, dynamic> element in jsonDecode(response.body) as List) {
        items.add(ProductItemModel.fromMap(element));
      }

      return Future(() => items);
    }

    return Future(() => []);
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}favorites/"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> items = [];

      for (Map<String, dynamic> element
          in jsonDecode(response.body) as List<dynamic>) {
        items.add((element));
      }

      return Future(() => items);
    }

    return Future(() => []);
  }

  @override
  Future<dynamic> removeOrAddItemFavorite(int itemId) async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}favorites/add/?item=$itemId"),
      body: jsonEncode({"item": itemId}),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      if (response.body == 'true') {
        return Future(() => true);
      }

      return Future(() => jsonDecode(response.body));
    }

    return Future(() => false);
  }
}
