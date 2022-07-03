import 'package:bloc/bloc.dart';
import 'package:deliveryhero/Business/Services/Repository.dart';
import 'package:deliveryhero/models/movieDetail.dart';
import 'package:meta/meta.dart';

part 'movie_detail_page_state.dart';

class MovieDetailPageCubit extends Cubit<MovieDetailPageState> {
  MovieDetailPageCubit() : super(MovieDetailPageInitial());

  loadMovieDetail(String movieId) async {
    var model = await Repository().getMovieDetail(movieId);

    emit(MovieDetailPageLoaded(model));
  }
}
