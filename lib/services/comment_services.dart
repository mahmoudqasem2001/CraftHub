import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';
import '../models/comment_model.dart';

abstract class CommentServices {
  Future<Either<ErrorMessageModel, List<Comment>>> getCommentsForItem(
      int itemId);
  Future<Either<ErrorMessageModel, bool>> postComment(
      int itemId, int userId, String comment);
}

class CommentServicesImpl extends CommentServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();

  @override
  Future<Either<ErrorMessageModel, List<Comment>>> getCommentsForItem(
      int itemId) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/comments/?item=$itemId"),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Comment> comments = responseData
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList();
      return Right(comments);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> postComment(
      int itemId, int userId, String comment) async {
    final response = await _authServices.authenticatedRequest(
      Uri.parse("${Constants.baseUrl}items/comments/"),
      method: 'POST',
      body: {
        "item": itemId.toString(),
        "user": userId.toString(),
        "comment": comment,
      },
    );

    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(ErrorMessageModel.fromJson(jsonDecode(response.body)));
    }
  }
}
