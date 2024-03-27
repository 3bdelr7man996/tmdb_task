import 'package:top_rated_movies/features/top_rated/data/datasources/top_rated_ds.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';

class TopRatedRepository {
  final TopRatedDS dataSource;

  TopRatedRepository({required this.dataSource});

  Future<TopRatedModel> getTopRatedMovies({
    required int page,
  }) async {
    TopRatedModel response = TopRatedModel.fromJson(
      await dataSource.getTopRatedMovies(page: page),
    );
    return response;
  }
}
