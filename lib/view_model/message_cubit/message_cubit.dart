/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/models/message_model.dart';
import 'package:grad_new_project/services/MessageServices.dart';
import 'package:grad_new_project/view_model/message_cubit/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  final MessagesServices messagesServices = MessagesServicesImpl();
  Future<void> fetchMessages(String chatRoomId) async {
    emit(MessageLoading());
    try {
      final result = await messagesServices.getMessages(chatRoomId);
      result.fold(
        (l) => emit(MessageFailure(l.detail)),
        (r) => emit(MessageListSuccess(r)),
      );
    } catch (e) {
      emit(MessageFailure(e.toString()));
    }
  }

  Future<void> sendMessage(String chatRoomId, Message newMessage) async {
    emit(MessageLoading());
    try {
      final result = await messagesServices.sendMessage(chatRoomId, newMessage);
      result.fold(
        (l) => emit(MessageFailure(l.detail)),
        (r) => emit(MessageSendSuccess()),
      );
    } catch (e) {
      emit(MessageFailure(e.toString()));
    }
  }
}
*/