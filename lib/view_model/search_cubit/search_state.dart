sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Map<String, dynamic>> result;

  SearchLoaded({required this.result});
}

final class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}
