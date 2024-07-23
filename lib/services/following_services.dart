import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/models/item_model.dart';

class FollowingService {
  Future<bool> followArtist(int profileId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await http.post(
      Uri.parse('${Constants.host}/follow-ups/follow/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'profile': profileId}),
    );

    return response.statusCode == 201;
  }

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

  Future<bool> unfollowArtist(int profileId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await http.delete(
      Uri.parse('${Constants.host}/follow-ups/unfollow/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'profile': profileId}),
    );

    return response.statusCode == 204;
  }
}
