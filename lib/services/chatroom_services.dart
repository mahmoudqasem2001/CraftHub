/*import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/models/chat_room_model.dart';
import 'package:grad_new_project/view_model/user_chats_cubit/user_chats_cubit.dart';

abstract class ChatRoomServices {
  Future<Either<ErrorMessageModel, List<ChatRoom>>> fetchAllUserChats(
      List<String> chatRoomIds);
  Future<Either<ErrorMessageModel, ChatRoom>> fetchChatRoom(String chatRoomId);
  Future<Either<ErrorMessageModel, void>> addChatRoom(ChatRoom chatRoom);
  Future<Either<ErrorMessageModel, String>> getOtherUserName(
      String currentUserId);
}

class ChatRoomServicesIMP extends ChatRoomServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<ErrorMessageModel, List<ChatRoom>>> fetchAllUserChats(
      List<String> chatRoomIds) async {
    final List<ChatRoom> chats = [];

    // Create a list of futures for fetching each chat room document
    final futures = chatRoomIds.map((chatroomId) async {
      final docRef = _firestore.collection('chatRooms').doc(chatroomId);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        chats.add(ChatRoom.fromDocument(docSnapshot));
      } else {
        return const Left(
            ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
      }
    }).toList();

    // Wait for all futures to complete
    await Future.wait(futures);
    if (chats.isEmpty) {
      return Left(ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
    } else {
      return Right(chats);
    }
  }

  @override
  Future<Either<ErrorMessageModel, ChatRoom>> fetchChatRoom(
      String chatRoomId) async {
    final ChatRoom chat;
    final docRef = _firestore.collection('chatRooms').doc(chatRoomId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      chat = ChatRoom.fromDocument(docSnapshot);

      return Right(chat);
    } else {
      return const Left(
          ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
    }
  }

//////////////////////////////////////////
  @override
  Future<Either<ErrorMessageModel, void>> addChatRoom(ChatRoom chatRoom) async {
    try {
      final docRef =
          _firestore.collection('chatRooms').doc(chatRoom.chatRoomId);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return Left(ErrorMessageModel(
            detail:
                'Chat room with ID ${chatRoom.chatRoomId} already exists.'));
      } else {
        await docRef.set(chatRoom.toMap());
        //print('Chat room added successfully');
        return const Right(Void);
      }
    } catch (e) {
      //print('Error adding chat room: $e');
      return Left(ErrorMessageModel(detail: 'Error adding chat room: $e'));
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> getOtherUserName(
      String currentUserId) async {
    final userDocRef = _firestore.collection('userChats').doc(currentUserId);
    final userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      final currentUserName = userDocSnapshot.data()!['userName'] as String;
      final chatDocRef = _firestore.collection('chatRooms').doc(currentUserId);
      final chatDocSnapshot = await chatDocRef.get();
      if (chatDocSnapshot.exists) {
        final user1Name = chatDocSnapshot.data()!['user1Name'] as String;
        final user2Name = chatDocSnapshot.data()!['user2Name'] as String;
        final String otherUserName;
        if (currentUserName == user1Name) {
          otherUserName = user2Name;
        } else {
          otherUserName = user1Name;
        }

        return Right(otherUserName);
      } else {
        return const Left(
            ErrorMessageModel(detail: "ChatDocSnapshot dose not exist"));
      }
    } else {
      return const Left(
          ErrorMessageModel(detail: "userDocSnapshot dose not exist"));
    }
  }
}
*/