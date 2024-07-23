import 'package:grad_new_project/models/chat_room_model.dart';
import 'package:grad_new_project/models/user_chats_model.dart';

sealed class UserChatsState {}

final class UserChatsInitial extends UserChatsState {}

final class UserChatsLoading extends UserChatsState {}

final class UserChatsListSuccess extends UserChatsState {
  final List<String> userChatsrooms;
  UserChatsListSuccess(this.userChatsrooms);
}

final class UserChatAddSuccess extends UserChatsState {}

final class UserChatsFailure extends UserChatsState {
  final String message;
  UserChatsFailure(this.message);
}
