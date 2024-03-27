import 'package:flutter/material.dart';
import 'package:top_rated_movies/core/utils/app_colors.dart';
import 'package:top_rated_movies/extensions/media_query_extension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
    this.padding = 0,
  });
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * padding),
      child: Center(
          child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.primaryColor.withOpacity(0.4),
        valueColor: const AlwaysStoppedAnimation<Color>(
          AppColors.primaryColor,
        ),
      )),
    );
  }
}
