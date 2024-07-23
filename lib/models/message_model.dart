/*import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final int senderId;
  final int receiverId;
  final String text;
  final Timestamp timestamp;
  final String chatRoomId;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.text,
      required this.timestamp,
      required this.chatRoomId});

  factory Message.fromFirestore(DocumentSnapshot snapshot) {
    return Message(
        senderId: snapshot.get('senderId'),
        receiverId: snapshot.get('receiverId'),
        text: snapshot.get('text'),
        timestamp: snapshot.get('timestamp'),
        chatRoomId: snapshot.get('chatRoomId'));
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'chatRoomId': chatRoomId,
      'text': text,
      'timestamp': timestamp
    };
  }
}
*/