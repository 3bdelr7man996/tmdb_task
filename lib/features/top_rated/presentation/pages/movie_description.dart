import 'package:flutter/material.dart';
import 'package:top_rated_movies/core/utils/app_colors.dart';
import 'package:top_rated_movies/core/utils/app_constants.dart';
import 'package:top_rated_movies/core/utils/app_strings.dart';
import 'package:top_rated_movies/extensions/padding_extension.dart';
import 'package:top_rated_movies/features/top_rated/data/models/top_rated_model.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/rate_widget.dart';

class MovieDescriptionScreen extends StatelessWidget {
  const MovieDescriptionScreen({super.key, required this.movie});
  final Results? movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              AppConstants.customNetworkImage(
                imagePath: "${AppStrings.imgBaseUrl}${movie?.posterPath}",
              ),
              15.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${movie?.title}",
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  20.pw,
                  RateWidget(
                    rating: (movie?.voteAverage ?? 0) / 2,
                  ),
                  15.ph,
                  Text(
                    "${movie?.overview}",
                    style: const TextStyle(color: AppColors.whiteColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
