/*import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatRoom {
  final String chatRoomId;
  final String lastMessage; // Handle potential missing field
  final String user1Name;
  final String user2Name;

  ChatRoom(
      {required this.chatRoomId,
      required this.lastMessage,
      required this.user1Name,
      required this.user2Name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatRoomId': chatRoomId,
      'lastMessage': lastMessage,
      'user1Name': user1Name,
      'user2Name': user2Name,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      chatRoomId: map['first_name'] as String,
      lastMessage: map['lastMessage'] as String,
      user1Name: map['user1Name'] as String,
      user2Name: map['user2Name'] as String,
    );
  }
  factory ChatRoom.fromDocument(DocumentSnapshot doc) {
    return ChatRoom(
      chatRoomId: doc['first_name'] as String,
      lastMessage: doc['lastMessage'] as String,
      user1Name: doc['user1Name'] as String,
      user2Name: doc['user2Name'] as String,
    );
  }
  String toJson() => json.encode(toMap());
  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);
}
*/