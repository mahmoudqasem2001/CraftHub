import 'dart:convert';

import 'package:grad_new_project/models/chat_room_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserChats {
  final String uid;
  final String userName;
  final List<String> chatRoomsIds;
  UserChats({
    required this.uid,
    required this.userName,
    required this.chatRoomsIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'chatRoomsIds': chatRoomsIds,
    };
  }

  factory UserChats.fromMap(Map<String, dynamic> map) {
    return UserChats(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      chatRoomsIds: map['chatRoomsIds'] as List<String>,
    );
  }
  String toJson() => json.encode(toMap());
  factory UserChats.fromJson(String source) =>
      UserChats.fromMap(json.decode(source) as Map<String, dynamic>);
}
