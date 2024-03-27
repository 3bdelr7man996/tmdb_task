import 'package:flutter/material.dart';
import 'package:top_rated_movies/core/utils/app_colors.dart';
import 'package:top_rated_movies/core/utils/app_constants.dart';
import 'package:top_rated_movies/core/utils/app_strings.dart';
import 'package:top_rated_movies/extensions/padding_extension.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';
import 'package:top_rated_movies/features/top_rated/presentation/pages/movie_description.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/rate_widget.dart';

class MovieGridTile extends StatelessWidget {
  const MovieGridTile({super.key, required this.movie});
  final Results? movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppConstants.navigatePush(
          context,
          MovieDescriptionScreen(
            movie: movie,
          )),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: AppColors.shimmerHeighlightColor,
          ),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: AppConstants.customNetworkImage(
                    imagePath: "${AppStrings.imgBaseUrl}${movie?.posterPath}",
                    fit: BoxFit.fill,
                    // width: 200,
                    // height: 150,
                  ),
                )),
            4.ph,
            Flexible(
              child: Text(
                movie?.title ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            RateWidget(
              rating: (movie?.voteAverage ?? 0) / 2,
            ),
          ],
        ),
      ),
    );
  }
}
