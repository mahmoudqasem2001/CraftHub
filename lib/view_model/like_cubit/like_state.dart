import '../../models/like_model.dart';

sealed class LikeState {}

final class LikeInitial extends LikeState {}

final class LikeLoading extends LikeState {}

final class LikeListSuccess extends LikeState {
  final List<Like> likes;
  LikeListSuccess(this.likes);
}

final class LikePostSuccess extends LikeState {}

final class LikeFailure extends LikeState {
  final String message;
  LikeFailure(this.message);
}
