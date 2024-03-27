// ignore_for_file: unnecessary_null_comparison

import 'package:get_it/get_it.dart';
import 'package:top_rated_movies/features/top_rated/data/datasources/top_rated_ds.dart';
import 'package:top_rated_movies/features/top_rated/data/repositories/top_rated_repo.dart';
import 'package:top_rated_movies/features/top_rated/presentation/cubit/top_rated_cubit.dart';

import 'core/utils/http_helper.dart';

final sl = GetIt.instance;
// String myBaseUrl = '';

Future<void> serviceLocatorInit() async {
  sl.allowReassignment = true;
  // Core
  sl.registerFactory(() => ApiBaseHelper());
  //DATA SOURCE

  sl.registerLazySingleton(() => TopRatedDS(apiHelper: sl()));

  //REPOSITORIES

  sl.registerLazySingleton(() => TopRatedRepository(dataSource: sl()));

  //CUBITS

  sl.registerFactory(() => TopRatedCubit(repository: sl()));
}

Future<void> resetAndReinitializeLocator() async {
  await sl.reset();
  await serviceLocatorInit();
}
