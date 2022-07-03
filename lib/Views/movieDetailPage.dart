// ignore_for_file: file_names

import 'package:deliveryhero/Business/Cubits/cubit/cubit/movie_detail_page_cubit.dart';
import 'package:deliveryhero/models/searchmovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage(this.movieResult, {Key? key}) : super(key: key);
  final Result movieResult;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieResult.title.toString())),
      body: BlocProvider(
        create: (context) => MovieDetailPageCubit()..loadMovieDetail(widget.movieResult.id.toString()),
        child: BlocBuilder<MovieDetailPageCubit, MovieDetailPageState>(
          builder: (context, state) {
            if (state is MovieDetailPageLoaded) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(children: [
                  RotatedBox(
                    quarterTurns: 45,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        imageBaseUrl + state.model.backdropPath.toString(),
                        color: Colors.white.withOpacity(0.7),
                        colorBlendMode: BlendMode.modulate,
                        errorBuilder: (context, exception, stackTrace) {
                          return const Image(
                            image: AssetImage("assets/placeholder.jpg"),
                          );
                        },
                        loadingBuilder: (context, widget, loadingProgress) {
                          if (loadingProgress == null) {
                            return widget;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              height: 220,
                              child: Stack(children: [
                                Image.network(
                                  imageBaseUrl + widget.movieResult.posterPath.toString(),
                                  loadingBuilder: (context, widget, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return widget;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, exception, stackTrace) {
                                    return const Image(
                                      image: AssetImage("assets/placeholder.jpg"),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 25,
                                  left: 10,
                                  child: Text(
                                    state.model.voteAverage.toString(),
                                    style: const TextStyle(color: Colors.blueAccent, fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.model.overview.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
