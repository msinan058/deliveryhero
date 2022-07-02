import 'package:deliveryhero/Business/Services/Repository.dart';
import 'package:deliveryhero/models/movieDetail.dart';
import 'package:deliveryhero/models/searchmovie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  setUp(() async {});

  test("Search movie api test", () async {
    var apiResult = await Repository().getSearchmovie("lord");

    expect(apiResult is SearchedMovieModel, true);
  });

  test("Get movie detail api test", () async {
    var apiResult = await Repository().getMovieDetail("18");

    expect(apiResult is MovieDetailModel, true);
  });
}
