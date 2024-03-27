import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated_movies/core/utils/app_colors.dart';
import 'package:top_rated_movies/core/utils/http_helper.dart';
import 'package:top_rated_movies/features/top_rated/presentation/cubit/top_rated_cubit.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/custom_loader.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/top_rate_widgets/movies_list_widget.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  @override
  void initState() {
    context.read<TopRatedCubit>().moviesScrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backGroundColor,
          title: const Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<TopRatedCubit, TopRatedState>(
          builder: (context, state) {
            if (state.moviesState == RequestState.loading && state.page == 1) {
              return const CustomLoader();
            } else if (state.moviesState == RequestState.failed) {
              return const Center(
                child: Text(
                  "Failed Loaded !!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return MoviesList(
                movieLength: state.moviesList?.length,
                moviesList: state.moviesList,
                page: state.page,
                moviesState: state.moviesState,
              );
            }
          },
        ));
  }
}
