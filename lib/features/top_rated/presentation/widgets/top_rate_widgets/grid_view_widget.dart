import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';
import 'package:top_rated_movies/features/top_rated/presentation/cubit/top_rated_cubit.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/top_rate_widgets/grid_tile_widget.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.movieLength,
    required this.moviesList,
  });
  final int? movieLength;
  final List<Results>? moviesList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GridView.builder(
          controller: context.read<TopRatedCubit>().scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.6,
          ),
          itemCount: moviesList?.length,
          itemBuilder: (context, index) {
            final movie = moviesList?[index];
            return MovieGridTile(
              movie: movie,
            );
          },
        ),
      ),
    );
  }
}
