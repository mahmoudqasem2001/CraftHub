import 'package:grad_new_project/models/item_model.dart';

abstract class FollowingState {}

class FollowingInitial extends FollowingState {}

class FollowingLoading extends FollowingState {}

class FollowingLoaded extends FollowingState {
  final List<Item> items;

  FollowingLoaded(this.items);
}

class FollowingFollowed extends FollowingState {}

class FollowingUnfollowed extends FollowingState {}

class FollowingError extends FollowingState {
  final String message;

  FollowingError(this.message);
}
