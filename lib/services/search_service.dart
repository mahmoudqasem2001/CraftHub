import 'dart:convert';

import 'package:grad_new_project/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Map<String, dynamic>>> search(
      bool isGeneral, String type, String value, int category) async {
    String url = '${Constants.baseUrl}search/';

    if (!isGeneral) {
      url = '$url?category=$category&item=$value';
    } else {
      url = '$url?$type=$value';
    }
    print(url);

    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> result = [];

      for (dynamic element in body) {
        result.add((element as Map<String, dynamic>));
      }

      return Future(() => result);
    }

    return Future(() => []);
  }
}
