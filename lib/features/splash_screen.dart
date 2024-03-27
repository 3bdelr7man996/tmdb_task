import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated_movies/core/utils/app_constants.dart';
import 'package:top_rated_movies/extensions/media_query_extension.dart';
import 'package:top_rated_movies/extensions/padding_extension.dart';
import 'package:top_rated_movies/features/top_rated/presentation/cubit/top_rated_cubit.dart';
import 'package:top_rated_movies/features/top_rated/presentation/widgets/custom_loader.dart';

import 'top_rated/presentation/pages/top_rated_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initConfigData() async {
    context.read<TopRatedCubit>().initData();
    await Future.wait([
      context.read<TopRatedCubit>().getTopRated(),
    ]);
  }

  @override
  void initState() {
    initConfigData().then((value) {
      AppConstants.navigatePushRemoveUntil(context, const TopRatedScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppConstants.customAssetImage(
                imagePath: "assets/icons/tmdb_logo.jpg",
                width: context.width / 2,
                height: context.width / 2,
                fit: BoxFit.contain,
              ),
              15.ph,
              const CustomLoader(),
            ],
          ),
        ),
      ),
    );
  }
}
