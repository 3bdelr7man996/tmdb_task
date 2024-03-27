import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:top_rated_movies/core/utils/http_helper.dart';
import 'package:top_rated_movies/core/utils/toast_helper.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';
import 'package:top_rated_movies/features/top_rated/data/repositories/top_rated_repo.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit({required this.repository}) : super(const TopRatedState());
  final TopRatedRepository repository;

  List<Results> moviesList = [];

  ///GET ALL ISSUES DATA
  Future<void> getTopRated() async {
    try {
      // if (state.page == 1) {
      //   moviesList = [];
      // }
      if (state.totalResults > moviesList.length || state.page == 1) {
        emit(state.copyWith(moviesState: RequestState.loading));
        TopRatedModel response =
            await repository.getTopRatedMovies(page: state.page);
        moviesList.addAll(response.results ?? []);
        emit(
          state.copyWith(
              moviesState: RequestState.success,
              moviesList: moviesList,
              totalPages:
                  state.page == 1 ? response.totalPages : state.totalPages,
              totalResults:
                  state.page == 1 ? response.totalResults : state.totalResults,
              page: state.page + 1),
        );
      }
    } catch (e) {
      emit(state.copyWith(moviesState: RequestState.failed));
      ShowToastHelper.showToast(msg: e.toString(), isError: true);
    }
  }

  /// INITIALIZE STATE DATA
  void initData() {
    moviesList = [];
    emit(
      state.copyWith(
        page: 1,
        moviesList: [],
        totalPages: 0,
        moviesState: RequestState.initial,
      ),
    );
  }

  ScrollController scrollController = ScrollController();
  void moviesScrollListener() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await getTopRated();
      }
    });
  }
}
