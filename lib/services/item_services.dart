import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item_model.dart';

abstract class ItemServices {
  Future<Either<ErrorMessageModel, List<Item>>> getItemsForArtist();
  Future<Either<ErrorMessageModel, Item>> createItemForArtist(Item item);
  Future<Either<ErrorMessageModel, Map<String, dynamic>>> getItemDetails(
      int id);
  Future<Either<ErrorMessageModel, bool>> updateItemForArtist(
      int id, Map<String, dynamic> updatedData);
  Future<Either<ErrorMessageModel, bool>> updateItemImageForArtist(
      int id, Map<String, dynamic> updatedData);
  Future<Either<ErrorMessageModel, bool>> deleteItemForArtist(int id);
  Future<Either<ErrorMessageModel, List<Item>>> getItemsForCustomerByArtist(
      int artistId);
  Future<Either<ErrorMessageModel, Item>> getItemDetailsForCustomer(int itemId);
}

class ItemServicesImpl extends ItemServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, List<Item>>> getItemsForArtist() async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      final List<Item> items =
          responseData.map((itemJson) => Item.fromMap(itemJson)).toList();

      return Right(items);
    } else {
      return Left(ErrorMessageModel.fromJson(response.body));
    }
  }

  @override
  Future<Either<ErrorMessageModel, Item>> createItemForArtist(Item item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${Constants.baseUrl}items/"),
    );

    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $accessToken",
    });

    request.fields['name'] = item.name;
    request.fields['price'] = item.price.toString();
    request.fields['description'] = item.description;
    request.fields['per_item'] = item.perItem.toString();

    File imageFile = File(item.image);
    http.ByteStream stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    int length = await imageFile.length();

    http.MultipartFile multipartFile = http.MultipartFile(
        'image', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final Item createdItem = Item.fromJson(response.body);
        return Right(createdItem);
      } else {
        return Left(ErrorMessageModel.fromJson(response.body));
      }
    } catch (e) {
      return const Left(ErrorMessageModel(detail: "Failed to send request"));
    }
  }

  @override
  Future<Either<ErrorMessageModel, Map<String, dynamic>>> getItemDetails(
      int id) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/$id/"),
      method: 'GET',
    );
    //print('hi' + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> comments = [];
      Map<String, dynamic> body = jsonDecode(response.body);
      final Item item = Item.fromMap(body);
      for (dynamic element in body['comments']) {
        comments.add(element as Map<String, dynamic>);
      }
      return Right({'item': item, 'comments': comments});
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> updateItemForArtist(
      int id, Map<String, dynamic> updatedData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (updatedData.containsKey('image')) {
      updatedData.remove('image');
    }

    final response = await http.patch(
      Uri.parse("${Constants.baseUrl}items/$id/"),
      body: jsonEncode(updatedData),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}",
      },
    );

    if (response.statusCode == 200) {
      // final responseData = jsonDecode(response.body);
      // final Item updatedItem = Item.fromJson(responseData);

      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> updateItemImageForArtist(
      int id, Map<String, dynamic> updatedData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse("${Constants.baseUrl}items/$id/"),
    );

    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $accessToken",
    });

    request.fields['name'] = updatedData['name'];
    request.fields['price'] = updatedData['price'].toString();
    request.fields['description'] = updatedData['description'];

    if (updatedData.containsKey('image')) {
      File imageFile = File(updatedData['image']);
      http.ByteStream stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      int length = await imageFile.length();

      http.MultipartFile multipartFile = http.MultipartFile(
          'image', stream, length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // final responseData = jsonDecode(response.body);
      // final Item updatedItem = Item.fromJson(responseData);
      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> deleteItemForArtist(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse("${Constants.baseUrl}items/$id/"),
      headers: {
        "Authorization": "Bearer ${prefs.getString('accessToken')}",
      },
    );

    if (response.statusCode == 204) {
      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<Item>>> getItemsForCustomerByArtist(
      int artistId) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/customers/?artist=$artistId"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Item> items =
          responseData.map((itemJson) => Item.fromJson(itemJson)).toList();
      return Right(items);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, Item>> getItemDetailsForCustomer(
      int itemId) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/customers/?item=$itemId"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      //print(response.body);

      final Item item = Item.fromJson(response.body);
      return Right(item);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
