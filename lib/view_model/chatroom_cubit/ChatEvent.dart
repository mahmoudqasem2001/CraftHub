/*import 'package:bloc/bloc.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_new_project/models/message_model.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String chatId;

  LoadMessages(this.chatId);
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String text;

  SendMessage(this.chatId, this.text);
}

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded(this.messages);
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._firestore) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final messages = await _getMessages(event.chatId);
        emit(ChatLoaded(messages));
      } catch (error) {
        emit(ChatError(error.toString()));
      }
    });

    on<SendMessage>((event, emit) async {
      emit(ChatLoading()); // Indicate loading state before sending
      try {
        await _sendMessage(event.chatId, event.text);
        final messages = await _getMessages(event.chatId); // Refresh messages
        emit(ChatLoaded(messages));
      } catch (error) {
        emit(ChatError(error.toString()));
      }
    });
  }

  final FirebaseFirestore _firestore;

  Future<List<ChatMessage>> _getMessages(String chatId) async {
    final messagesRef =
        _firestore.collection('chats').doc(chatId).collection('messages');
    final snapshot =
        await messagesRef.orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList();
  }

  Future<void> _sendMessage(String chatId, String text) async {
    final messagesRef =
        _firestore.collection('chats').doc(chatId).collection('messages');
    await messagesRef.add({
      'senderId':
          '/* replace with your logic to get sender ID */', // Implement sender ID logic
      'receiverId':
          '/* replace with your logic to get receiver ID */', // Implement receiver ID logic
      'text': text,
      'timestamp': Timestamp.now(),
    });
  }
}
*/