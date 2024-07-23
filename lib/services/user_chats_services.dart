/*import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/models/chat_room_model.dart';
import 'package:grad_new_project/models/user_chats_model.dart';
import 'package:grad_new_project/services/auth_services.dart';
import 'package:grad_new_project/shared/constants.dart';
import '../models/comment_model.dart';

abstract class UserChatsServices {
  Future<Either<ErrorMessageModel, List<String>>> getChatsRoomsListForUser(
      String userId);

  Future<Either<ErrorMessageModel, bool>> addChatForUser(
      String userId, String chatRoomId);
}

class UserChatsServicesImpl extends UserChatsServices {
  final AuthServicesImpl _authServices = AuthServicesImpl();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //it returns a List of Strings containes the chat rooms ides for this user
  @override
  Future<Either<ErrorMessageModel, List<String>>> getChatsRoomsListForUser(
      String userId) async {
    final userDocRef = _firestore.collection('userChats').doc(userId);
    final userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      final userChatRoomsIds =
          userDocSnapshot.data()!['chatRoomsIds'] as List<String>;
      return Right(userChatRoomsIds);
    } else {
      return Left(ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> addChatForUser(
      String userId, String chatRoomId) async {
    // TODO: implement addChatForUser
    final userDocRef = _firestore.collection('userChats').doc(userId);

    try {
      // Attempt to update the user document with the new chat room ID
      final transaction = await _firestore.runTransaction((transaction) async {
        final userDocSnapshot = await transaction.get(userDocRef);
        if (!userDocSnapshot.exists) {
          const Left(
              ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
        }
        // Get existing chat room IDs
        final existingChatRooms =
            userDocSnapshot.data()!['chatRoomsIds'] as List<String> ?? [];

        // Check if chat room already exists
        if (existingChatRooms.contains(chatRoomId)) {
          return const Left(
              ErrorMessageModel(detail: "chat room already exists"));
        }
        // Add the new chat room ID to the list
        existingChatRooms.add(chatRoomId); // Convert chatRoomId to String

        // Update the user document with the updated chat room list
        transaction.update(userDocRef, {'chatRoomsIds': existingChatRooms});
      });
      return Right(true); // Indicate successful update
    } catch (error) {
      //print('Error adding chat for user: $error');
      return Left(
          ErrorMessageModel(detail: error.toString())); // Handle error message
    }
  }

/*
  @override
  Future<Either<ErrorMessageModel, bool>> addChatForUser(
    int userId,
    int otherUserId,
  ) async {
    final userDocRef =
        _firestore.collection('userChats').doc(userId.toString());

    try {
      // Attempt to update the user document with the new chat room ID
      final transaction = await _firestore.runTransaction((transaction) async {
        final userDocSnapshot = await transaction.get(userDocRef);
        if (!userDocSnapshot.exists) {
          Left(ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
        }
        // Get existing chat room IDs
        final existingChatRooms =
            userDocSnapshot.data()!['chatRooms'] as List<String> ?? [];

        // Check if chat room already exists
        if (existingChatRooms.contains(chatRoomId.toString())) {
          throw Exception('Chat room already exists for user!');
        }

        // Add the new chat room ID to the list
        existingChatRooms
            .add(chatRoomId.toString()); // Convert chatRoomId to String

        // Update the user document with the updated chat room list
        transaction.update(userDocRef, {'chatRooms': existingChatRooms});
      });

      return Right(true); // Indicate successful update
    } catch (error) {
      //print('Error adding chat for user: $error');
      return Left(
          ErrorMessageModel(detail: error.toString())); // Handle error message
    }
  }

  @override
  Future<List<ChatRoom>> fetchChatDetails(List<String> chatRoomIds) {
    // TODO: implement fetchChatDetails
    throw UnimplementedError();
  }

/*  @override
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
  }*/*/
}
*/