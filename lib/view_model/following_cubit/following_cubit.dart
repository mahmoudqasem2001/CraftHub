import 'package:bloc/bloc.dart';
import 'package:grad_new_project/view_model/following_cubit/following_state.dart';

import '../../services/following_services.dart';

class FollowingCubit extends Cubit<FollowingState> {
  final FollowingService followingService;

  FollowingCubit(this.followingService) : super(FollowingInitial());

  Future<void> followArtist(int profileId) async {
    try {
      emit(FollowingLoading());
      final success = await followingService.followArtist(profileId);
      if (success) {
        emit(FollowingFollowed());
      } else {
        emit(FollowingError('Failed to follow artist'));
      }
    } catch (e) {
      emit(FollowingError('Failed to follow artist: $e'));
    }
  }

  Future<void> getArtistInfo(int artistId) async {
    try {
      emit(FollowingLoading());
      final account = await followingService.getArtistInfo(artistId);
      emit(FollowingLoaded(account));
    } catch (e) {
      emit(FollowingError('Failed to load artist account information'));
    }
  }

  Future<void> unfollowArtist(int profileId) async {
    try {
      emit(FollowingLoading());
      final success = await followingService.unfollowArtist(profileId);
      if (success) {
        emit(FollowingUnfollowed());
      } else {
        emit(FollowingError('Failed to unfollow artist'));
      }
    } catch (e) {
      emit(FollowingError('Failed to unfollow artist: $e'));
    }
  }
}
