/*import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_new_project/core/network/error_message_model.dart';
import 'package:grad_new_project/models/message_model.dart';

abstract class MessagesServices {
  Future<Either<ErrorMessageModel, List<Message>>> getMessages(
      String chatRoomId);
  Future<Either<ErrorMessageModel, void>> sendMessage(
      String chatRoomId, Message newMessage);
}

class MessagesServicesImpl extends MessagesServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<ErrorMessageModel, List<Message>>> getMessages(
      String chatRoomId) async {
    try {
      final messagesRef = _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages');

      // Check if the chat room exists
      final chatRoomSnapshot =
          await _firestore.collection('chatRooms').doc(chatRoomId).get();
      if (!chatRoomSnapshot.exists) {
        return Left(ErrorMessageModel(detail: 'Chat room not defined'));
      }

      final snapshot =
          await messagesRef.orderBy('timestamp', descending: true).get();

      return Right(
          snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
    } catch (e) {
      //print('Error fetching messages: $e');
      return Left(ErrorMessageModel(detail: 'Error fetching messages: $e'));
    }
  }

  @override
  Future<Either<ErrorMessageModel, void>> sendMessage(
      String chatRoomId, Message newMessage) async {
    try {
      final messagesRef = _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages');

      // Check if the chat room exists
      final chatSnapshot =
          await _firestore.collection('chat').doc(chatRoomId).get();
      if (!chatSnapshot.exists) {
        return Left(ErrorMessageModel(detail: 'Chat room not defined'));
      }

      // Add the message to the messages sub-collection
      await messagesRef.add(newMessage.toFirestore());
      //print('Message sent successfully');
      return const Right(Void);
    } catch (e) {
      //print('Error sending message: $e');
      return Left(ErrorMessageModel(detail: 'Error sending message: $e'));
    }
  }
}
*/