import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/error_message_model.dart';
import '../models/artist_model.dart';
import '../models/user_model.dart';
import '../shared/constants.dart';

abstract class AuthServices {
  Future<Either<ErrorMessageModel, bool>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<ErrorMessageModel, bool>> signUpAsArtist(
      String firstName,
      String lastName,
      String email,
      String country,
      String state,
      String city,
      String projectName,
      String password);
  Future<Either<ErrorMessageModel, bool>> signUpAsUser(
      String firstName,
      String lastName,
      String email,
      String country,
      String state,
      String city,
      String password);
  Future<void> signOut();
  Future<http.Response> authenticatedRequest(
    Uri url, {
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
  Future<bool> refreshAccessToken();
  Future<Either<ErrorMessageModel, bool>> createProfile({
    required int gender,
    required String birthDate,
    required String image,
    required Map<String, int> interestedCategories,
    String? newCategory,
  });
  Future<List<CategoryModel>> getCategories();
}

class AuthServicesImpl extends AuthServices {
  @override
  Future<Either<ErrorMessageModel, bool>> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/login/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', responseData['access']);
      await prefs.setString('refreshToken', responseData['refresh']);

      final String userType = responseData['type'];
      await prefs.setString('userType', userType);
      final bool isFinished = responseData['is_finish'];

      return Right(isFinished);
    } else {
      return Left(ErrorMessageModel.fromJson(response.body));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> signUpAsArtist(
      String firstName,
      String lastName,
      String email,
      String country,
      String state,
      String city,
      String projectName,
      String password) async {
    print(firstName);
    print(lastName);
    print(projectName);
    print(city);
    print(country);
    print(state);
    print(email);
    print(password);
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/artists/register/"),
      body: jsonEncode(
        ArtistModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          country: country,
          state: state,
          city: city,
          projectName: projectName,
          password: password,
        ).toMap(),
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('refreshToken', responseData['refresh']);
      await prefs.setString('accessToken', responseData['access']);

      return const Right(true);
    } else {
      print(response.body);
      return Left(ErrorMessageModel.fromJson(response.body));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> signUpAsUser(
      String firstName,
      String lastName,
      String email,
      String country,
      String state,
      String city,
      String password) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/customers/register/"),
      body: jsonEncode(
        UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          country: country,
          state: state,
          city: city,
          password: password,
        ).toMap(),
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('refreshToken', responseData['refresh']);
      await prefs.setString('accessToken', responseData['access']);

      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(response.body));
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    //print('logout');
    if (accessToken != null) {
      final response = await authenticatedRequest(
        Uri.parse("${Constants.baseUrl}auth/logout/"),
        method: 'POST',
      );

      if (response.statusCode == 200) {
        await prefs.remove('accessToken');
        await prefs.remove('refreshToken');
      }
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
    // //print(response.body);

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
      await signOut();
      return false;
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> createProfile({
    required int gender,
    required String birthDate,
    required String image,
    required Map<String, int> interestedCategories,
    String? newCategory,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String accessToken = prefs.getString('accessToken') ?? '';

      print('access: ------- $accessToken');

      final Uri uri = Uri.parse('${Constants.baseUrl}auth/profile/create/');

      final Map<String, int> interestedCategoriesMap = interestedCategories
          .map((key, value) => MapEntry(key.toString(), value));
      final String interestedCategoriesJson =
          jsonEncode(interestedCategoriesMap);

      //print(interestedCategoriesJson);
      birthDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(birthDate));
      //print(birthDate);

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..fields['gender'] = gender.toString()
        ..fields['birth_of_date'] = birthDate
        ..fields['interested_categories'] = interestedCategoriesJson;

      File imageFile = File(image);
      http.ByteStream stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      int length = await imageFile.length();

      http.MultipartFile multipartFile = http.MultipartFile(
          'image', stream, length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);
      print(request.fields);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(ErrorMessageModel.fromJson(response.body));
      }
    } catch (e) {
      //print('Error creating profile: $e');
      throw e.toString();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    String accessToken = '';

    await SharedPreferences.getInstance().then((value) {
      accessToken = value.getString('accessToken') ?? '';
    });

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}categories/register/"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<CategoryModel> categories = [];
      for (Map<String, dynamic> element in jsonDecode(response.body) as List) {
        categories.add(CategoryModel.fromMap(element));
      }

      return Future(() => categories);
    }

    return Future(() => []);
  }
}
