part of 'top_rated_cubit.dart';

class TopRatedState extends Equatable {
  const TopRatedState({
    this.page = 1,
    this.moviesList,
    this.totalPages = 0,
    this.totalResults = 0,
    this.moviesState = RequestState.initial,
  });
  final int page;
  final List<Results>? moviesList;
  final int totalPages;
  final int totalResults;
  final RequestState moviesState;
  @override
  List<Object?> get props => [
        page,
        moviesList,
        totalPages,
        totalResults,
        moviesState,
      ];
  TopRatedState copyWith({
    int? page,
    List<Results>? moviesList,
    int? totalPages,
    int? totalResults,
    RequestState? moviesState,
  }) =>
      TopRatedState(
        moviesList: moviesList ?? this.moviesList,
        moviesState: moviesState ?? this.moviesState,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );
}
