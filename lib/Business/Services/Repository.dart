// ignore_for_file: file_names

import 'dart:convert';

import 'package:deliveryhero/models/movieDetail.dart';
import 'package:deliveryhero/models/searchmovie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Repository {
  String apiKey = "35ef0461fc4557cf1d256d3335ed7545";
  /* Future<SearchedMovieModel> */ getSearchmovie(String movieQuery, {String pageNumber = "1"}) async {
    try {
      var response = await Dio().get("https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$movieQuery&page=$pageNumber");

      if (response.statusCode == 200) {
        var modelResult = SearchedMovieModel.fromJson(response.data);

        return modelResult;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /* Future<MovieDetailModel> */ getMovieDetail(String movieId) async {
    try {
      var response = await Dio().get("https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey");

      if (response.statusCode == 200) {
        var modelResult = MovieDetailModel.fromRawJson(jsonEncode(response.data));

        return modelResult;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
