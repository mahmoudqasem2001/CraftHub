import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';
import '../models/like_model.dart';

abstract class LikeServices {
  Future<Either<ErrorMessageModel, List<Like>>> getLikesForItem(int itemId);
  Future<Either<ErrorMessageModel, bool>> postLike(int itemId, int userId);
}

class LikeServicesImpl extends LikeServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, List<Like>>> getLikesForItem(
      int itemId) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/likes/?item=$itemId"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Like> likes =
          responseData.map((likeJson) => Like.fromJson(likeJson)).toList();
      return Right(likes);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> postLike(
      int itemId, int userId) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/likes/"),
      method: 'POST',
      body: {
        "item": itemId.toString(),
        "user": userId.toString(),
      },
    );

    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
