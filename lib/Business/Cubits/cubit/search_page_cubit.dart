import 'package:bloc/bloc.dart';
import 'package:deliveryhero/Business/Services/Repository.dart';
import 'package:deliveryhero/models/searchmovie.dart';
import 'package:meta/meta.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(SearchPageInitial());

  SearchedMovieModel model = SearchedMovieModel();
  SearchedMovieModel newModel = SearchedMovieModel();
  int pageNumber = 1;
  searchMovie(
    String movieQuery,
  ) async {
    emit(SearchPageLoading());
    model = await Repository().getSearchmovie(movieQuery);

    if (model.results != null && model.results!.isNotEmpty) {
      pageNumber = 1;
      emit(SearchPageLoaded(model));
    } else {
      emit(SearchPageFailed());
    }
  }

  searchMoreMovie(
    String movieQuery,
  ) async {
    if (pageNumber < model.totalPages!) pageNumber++;

    newModel = await Repository().getSearchmovie(movieQuery, pageNumber: pageNumber.toString());

    if (newModel.results!.isEmpty) {
      emit(SearchPageLoaded(model, noMoreMovie: true));
    }
    model.results!.addAll(newModel.results!);
    emit(SearchPageLoaded(model));
  }

  searchMovieClear() async {
    emit(SearchPageInitial());
  }
}
