import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/constants.dart';

abstract class TokenServices {
  Future<http.Response> authenticatedRequest(
    Uri url, {
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<bool> refreshAccessToken();
}

class TokenServicesImpl extends TokenServices {
  @override
  Future<bool> refreshAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null) {
      return false;
    }

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/tokens/refresh/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}",
      },
      body: jsonEncode({"refresh": refreshToken}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      await prefs.setString('accessToken', responseData['access']);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<http.Response> authenticatedRequest(
    Uri url, {
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    // Set default headers if not provided
    headers = headers ?? {};
    headers['Authorization'] = 'Bearer $accessToken';
    headers['Content-Type'] = 'application/json';

    // Perform the initial request
    http.Response response;
    switch (method) {
      case 'POST':
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case 'GET':
      default:
        response = await http.get(url, headers: headers);
        break;
    }

    if (response.statusCode == 401) {
      bool tokenRefreshed = await refreshAccessToken();
      if (tokenRefreshed) {
        accessToken = prefs.getString('accessToken');
        headers['Authorization'] = 'Bearer $accessToken';

        switch (method) {
          case 'POST':
            response =
                await http.post(url, headers: headers, body: jsonEncode(body));
            break;
          case 'GET':
          default:
            response = await http.get(url, headers: headers);
            break;
        }
      }
    }

    return response;
  }
}
