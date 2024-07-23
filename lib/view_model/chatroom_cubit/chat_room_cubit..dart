/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/services/chatroom_services.dart';
import 'package:grad_new_project/view_model/chatroom_cubit/chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  final ChatRoomServices chatRoomServices = ChatRoomServicesIMP();
  Future<void> fetchChatsForUser(List<String> chatRoomsIds) async {
    emit(ChatRoomLoading());
    try {
      final result = await chatRoomServices.fetchAllUserChats(chatRoomsIds);
      result.fold(
        (l) => emit(ChatRoomFailure(l.detail)),
        (r) => emit(ChatRoomListSuccess(r)),
      );
    } catch (e) {
      emit(ChatRoomFailure(e.toString()));
    }
  }

  Future<void> fetchChatForUser(String chatRoomId) async {
    emit(ChatRoomLoading());
    try {
      final result = await chatRoomServices.fetchChatRoom(chatRoomId);
      result.fold(
        (l) => emit(ChatRoomFailure(l.detail)),
        (r) => emit(ChatRoomSuccess(r)),
      );
    } catch (e) {
      emit(ChatRoomFailure(e.toString()));
    }
  }

  Future<void> fetchOtherUserName(String currentUserId) async {
    emit(ChatRoomLoading());
    try {
      final result = await chatRoomServices.getOtherUserName(currentUserId);
      result.fold(
        (l) => emit(ChatRoomFailure(l.detail)),
        (r) => emit(ChatRoomAddSuccess()),
      );
    } catch (e) {
      emit(ChatRoomFailure(e.toString()));
    }
  }
}
*/