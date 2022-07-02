part of 'search_page_cubit.dart';

@immutable
abstract class SearchPageState {}

class SearchPageInitial extends SearchPageState {}

class SearchPageLoading extends SearchPageState {}

class SearchPageLoaded extends SearchPageState {
  SearchPageLoaded(this.model, {this.noMoreMovie = false});

  final SearchedMovieModel model;
  final bool noMoreMovie;
}

class SearchPageFailed extends SearchPageState {}
