import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:grad_new_project/models/account_model.dart';
import 'package:grad_new_project/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item_model.dart';
import '../shared/constants.dart';

abstract class AccountServices {
  Future<AccountModel> fetchArtistAccountInfo();
  Future<AccountModel> updateArtistAccountInfo(
      Map<String, dynamic> updatedFields);
  Future<AccountModel> fetchCustomerAccountInfo();
  Future<AccountModel> updateCustomerAccountInfo(
      Map<String, dynamic> updatedFields);
  Future<Profile> updateProfileInfo(Map<String, dynamic> updatedFields);
  Future<List<Item>> getArtistInfo(int artistId);
}

class AccountServicesImpl implements AccountServices {
  Future<List<Item>> getArtistInfo(int artistId) async {
    final url =
        Uri.parse('${Constants.baseUrl}items/customers/?artist=$artistId');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<Item> items = jsonData.map((json) => Item.fromMap(json)).toList();
      return items;
    } else {
      throw Exception('Failed to load items for artist $artistId');
    }
  }

  @override
  Future<AccountModel> fetchArtistAccountInfo() async {
    final url = Uri.parse('${Constants.baseUrl}accounts/artists/');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    //print(token);

    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      //print("-----------" + response.body);

      return AccountModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load artist account information');
    }
  }

  @override
  Future<AccountModel> updateArtistAccountInfo(
      Map<String, dynamic> updatedFields) async {
    final url = Uri.parse('${Constants.baseUrl}accounts/artists/');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    //print(token);

    final response = await http.patch(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedFields),
    );
    //print(response);

    if (response.statusCode == 200) {
      return AccountModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update artist account information');
    }
  }

  @override
  Future<AccountModel> fetchCustomerAccountInfo() async {
    final url = Uri.parse('${Constants.baseUrl}accounts/customers/');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    //print(token);

    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.body);
    if (response.statusCode == 200) {
      return AccountModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load customer account information');
    }
  }

  @override
  Future<AccountModel> updateCustomerAccountInfo(
      Map<String, dynamic> updatedFields) async {
    final url = Uri.parse('${Constants.baseUrl}accounts/customers/');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await http.patch(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedFields),
    );

    if (response.statusCode == 200) {
      return AccountModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update customer account information');
    }
  }

  @override
  Future<Profile> updateProfileInfo(Map<String, dynamic> updatedFields) async {
    final url = Uri.parse('${Constants.baseUrl}accounts/profiles/update/');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    var request = http.MultipartRequest('PATCH', url);

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    updatedFields.forEach((key, value) {
      if (key != 'image') {
        request.fields[key] = value.toString();
      }
    });

    if (updatedFields['image'] != null) {
      File imageFile = File(updatedFields['image']);
      if (await imageFile.exists()) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imageFile.path));
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return Profile.fromJson(response.body);
      } else {
        throw Exception(
            'Failed to update profile information: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }
  }
}
