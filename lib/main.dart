import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated_movies/core/utils/app_strings.dart';
import 'package:top_rated_movies/core/utils/cache_helper.dart';
import 'config/bloc_config/bloc_provider.dart';
import 'config/themes/app_themes.dart';
import 'di_container.dart' as di;

import 'config/bloc_config/bloc_observer.dart';
import 'features/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  di.serviceLocatorInit();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return blocMultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: appTheme(),
        builder: BotToastInit(),
        //onGenerateRoute: AppRouter.generatedRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
