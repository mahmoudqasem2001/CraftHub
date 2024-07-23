import '../../models/comment_model.dart';

sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentListSuccess extends CommentState {
  final List<Comment> comments;
  CommentListSuccess(this.comments);
}

final class CommentPostSuccess extends CommentState {}

final class CommentFailure extends CommentState {
  final String message;
  CommentFailure(this.message);
}
