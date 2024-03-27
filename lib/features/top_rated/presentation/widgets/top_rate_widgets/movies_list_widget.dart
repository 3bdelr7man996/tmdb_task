import 'package:flutter/material.dart';
import 'package:top_rated_movies/core/utils/http_helper.dart';
import 'package:top_rated_movies/extensions/padding_extension.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/custom_loader.dart';

import 'grid_view_widget.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.movieLength,
    required this.moviesList,
    required this.page,
    required this.moviesState,
  });
  final int? movieLength;
  final List<Results>? moviesList;
  final RequestState moviesState;
  final int page;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.ph,
        GridViewWidget(
          movieLength: moviesList?.length,
          moviesList: moviesList,
        ),
        if (moviesState == RequestState.loading && page > 1)
          const SizedBox(
            height: 15,
            width: 15,
            child: CustomLoader(),
          ),
      ],
    );
  }
}
