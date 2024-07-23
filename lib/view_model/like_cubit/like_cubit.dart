import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/like_services.dart';
import 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeInitial());

  final LikeServices likeServices = LikeServicesImpl();

  Future<void> fetchLikesForItem(int itemId) async {
    emit(LikeLoading());
    try {
      final result = await likeServices.getLikesForItem(itemId);
      result.fold(
        (l) => emit(LikeFailure(l.detail)),
        (r) => emit(LikeListSuccess(r)),
      );
    } catch (e) {
      emit(LikeFailure(e.toString()));
    }
  }

  Future<void> postLike(int itemId, int userId) async {
    emit(LikeLoading());
    try {
      final result = await likeServices.postLike(itemId, userId);
      result.fold(
        (l) => emit(LikeFailure(l.detail)),
        (r) => emit(LikePostSuccess()),
      );
    } catch (e) {
      emit(LikeFailure(e.toString()));
    }
  }
}
