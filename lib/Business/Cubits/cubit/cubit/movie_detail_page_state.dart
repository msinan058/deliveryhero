part of 'movie_detail_page_cubit.dart';

@immutable
abstract class MovieDetailPageState {}

class MovieDetailPageInitial extends MovieDetailPageState {}

class MovieDetailPageLoading extends MovieDetailPageState {}

class MovieDetailPageLoaded extends MovieDetailPageState {
  MovieDetailPageLoaded(this.model);

  final MovieDetailModel model;
}

class MovieDetailPageFailed extends MovieDetailPageState {}
