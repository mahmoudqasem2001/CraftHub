import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/services/search_service.dart';
import 'package:grad_new_project/view_model/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchService searchService;

  SearchCubit({required this.searchService}) : super(SearchInitial());

  void search(bool isGeneral, String type, String value,
      [int category = 0]) async {
    emit(SearchLoading());
    try {
      List<Map<String, dynamic>> result =
          await searchService.search(isGeneral, type, value, category);

      emit(
        SearchLoaded(
          result: result,
        ),
      );
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

  void clear() {
    emit(
      SearchLoading(),
    );
    emit(
      SearchLoaded(
        result: [],
      ),
    );
  }
}
