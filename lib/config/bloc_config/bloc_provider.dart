import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:top_rated_movies/di_container.dart' as di;
import 'package:top_rated_movies/features/top_rated/presentation/cubit/top_rated_cubit.dart';

MultiBlocProvider blocMultiProvider({required child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<TopRatedCubit>(
        create: (BuildContext context) => di.sl<TopRatedCubit>(),
      ),
    ],
    child: child,
  );
}
