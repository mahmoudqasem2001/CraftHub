import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/comment_services.dart';
import 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  final CommentServices commentServices = CommentServicesImpl();

  Future<void> fetchCommentsForItem(int itemId) async {
    emit(CommentLoading());
    try {
      final result = await commentServices.getCommentsForItem(itemId);
      result.fold(
        (l) => emit(CommentFailure(l.detail)),
        (r) => emit(CommentListSuccess(r)),
      );
    } catch (e) {
      emit(CommentFailure(e.toString()));
    }
  }

  Future<void> postComment(int itemId, int userId, String comment) async {
    emit(CommentLoading());
    try {
      final result = await commentServices.postComment(itemId, userId, comment);
      result.fold(
        (l) => emit(CommentFailure(l.detail)),
        (r) => emit(CommentPostSuccess()),
      );
    } catch (e) {
      emit(CommentFailure(e.toString()));
    }
  }
}
