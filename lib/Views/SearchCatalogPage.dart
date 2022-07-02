// ignore_for_file: deprecated_member_use, file_names

import 'package:deliveryhero/Business/Cubits/cubit/search_page_cubit.dart';
import 'package:deliveryhero/Views/movieCatalogPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  TextEditingController tecSearchmovie = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool _isWriting = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPageCubit(),
      child: BlocListener<SearchPageCubit, SearchPageState>(
        listener: (context, state) {
          if (state is SearchPageLoaded) {
            if (state.noMoreMovie) {
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text("No Much More Movie"),
                backgroundColor: Colors.red,
              ));
            }
          }
        },
        child: BlocBuilder<SearchPageCubit, SearchPageState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search movie',
                    ),
                    controller: tecSearchmovie,
                    onChanged: (value) async {
                      if (value.length >= 2) {
                        if (!_isWriting) {
                          _isWriting = true;
                          setState(() {});
                          Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() {
                            _isWriting = false;
                            context.read<SearchPageCubit>().searchMovie(value);
                          });
                        }
                      } else {
                        context.read<SearchPageCubit>().searchMovieClear();
                      }
                    },
                  ),
                  state is SearchPageLoaded ? MovieCatalogView(state.model, tecSearchmovie.text, scrollController) : Container(),
                  state is SearchPageLoading
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        )
                      : Container(),
                  state is SearchPageFailed
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Expanded(
                            child: Text(
                              "An Error Accured Or Movie Not Found Please Try Again",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ))
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
