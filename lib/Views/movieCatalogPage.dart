// ignore_for_file: file_names

import 'package:deliveryhero/Business/Cubits/cubit/search_page_cubit.dart';
import 'package:deliveryhero/Views/movieDetailPage.dart';
import 'package:deliveryhero/models/searchmovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCatalogView extends StatefulWidget {
  const MovieCatalogView(this.model, this.movieNameQuery, this.scrollController, {Key? key}) : super(key: key);

  final String movieNameQuery;
  final SearchedMovieModel model;
  final ScrollController scrollController;
  @override
  State<MovieCatalogView> createState() => _MovieCatalogViewState();
}

class _MovieCatalogViewState extends State<MovieCatalogView> {
  @override
  void initState() {
    scrollControllerListener();
    super.initState();
  }

  @override
  void dispose() {
    // widget.scrollController.dispose();
    super.dispose();
  }

  String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  @override
  Widget build(BuildContext context) {
    return widget.movieNameQuery.length > 1
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.model.results!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => MovieDetailPage(widget.model.results![index]))));
                    },
                    child: SizedBox(
                        height: 450,
                        width: 300,
                        child: Stack(
                          children: [
                            Image.network(
                              imageBaseUrl + widget.model.results![index].posterPath.toString(),
                              fit: BoxFit.fill,
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
                            Positioned(bottom: 1, child: Text(widget.model.results![index].title.toString())),
                            Positioned(
                              bottom: 25,
                              left: 10,
                              child: Text(
                                widget.model.results![index].voteAverage.toString(),
                                style: const TextStyle(color: Colors.blueAccent, fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  );
                }),
          )
        : Container();
  }

  scrollControllerListener() {
    if (widget.scrollController.hasClients) {
      widget.scrollController.addListener(() async {
        if (widget.scrollController.position.maxScrollExtent == widget.scrollController.offset) {
          context.read<SearchPageCubit>().searchMoreMovie(
                widget.movieNameQuery,
              );
        }
      });
    }
  }
}
