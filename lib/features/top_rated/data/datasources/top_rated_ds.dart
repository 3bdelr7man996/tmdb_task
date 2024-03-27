import 'package:top_rated_movies/core/utils/app_strings.dart';
import 'package:top_rated_movies/core/utils/http_helper.dart';

class TopRatedDS {
  final ApiBaseHelper apiHelper;
  TopRatedDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getTopRatedMovies({
    int page = 1,
  }) async {
    Map<String, dynamic>? response =
        await apiHelper.get(AppStrings.discoverMovie, queryParameters: {
      "page": "$page",
      "api_key": AppStrings.apiKey,
    });
    return response;
  }
}
