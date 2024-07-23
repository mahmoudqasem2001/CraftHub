/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/services/user_chats_services.dart';
import 'package:grad_new_project/view_model/user_chats_cubit/user_chats_state.dart';

class UserChatsCubit extends Cubit<UserChatsState> {
  UserChatsCubit() : super(UserChatsInitial());

  final UserChatsServices userChatsServices = UserChatsServicesImpl();

  Future<void> fetchChatsForUser(String userId) async {
    emit(UserChatsLoading());
    try {
      final result = await userChatsServices.getChatsRoomsListForUser(userId);
      result.fold(
        (l) => emit(UserChatsFailure(l.detail)),
        (r) => emit(UserChatsListSuccess(r)),
      );
    } catch (e) {
      emit(UserChatsFailure(e.toString()));
    }
  }

  Future<void> addChatForUser(String userId, String chatRoomId) async {
    emit(UserChatsLoading());
    try {
      final result = await userChatsServices.addChatForUser(userId, chatRoomId);
      result.fold(
        (l) => emit(UserChatsFailure(l.detail)),
        (r) => emit(UserChatAddSuccess()),
      );
    } catch (e) {
      emit(UserChatsFailure(e.toString()));
    }
  }
/*
  Future<void> fetchCurrentUserName(String userId) async {
    emit(UserChatsLoading());
    try {
      final result = await userChatsServices.getCurrentUserName(userId);
      result.fold(
        (l) => emit(UserChatsFailure(l.detail)),
        (r) => emit(UserNameSuccess(r)),
      );
    } catch (e) {
      emit(UserChatsFailure(e.toString()));
    }
  }*/

/*
  Future<void> postComment(int itemId, int userId, String comment) async {
    /* emit(UserChatsLoading());
    try {
      final result =
          await UserChatsServices.postComment(itemId, userId, comment);
      result.fold(
        (l) => emit(CommentFailure(l.detail)),
        (r) => emit(CommentPostSuccess()),
      );
    } catch (e) {
      emit(CommentFailure(e.toString()));
    }
  }*/
  }*/
}
*/