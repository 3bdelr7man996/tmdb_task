import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: AppColors.backGroundColor,
    fontFamily: 'ElMessiri',
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      hintStyle: const TextStyle(color: AppColors.lightGrayColor),
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.3,
          color: Colors.grey[300]!,
        ),

        //borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.3,
          color: AppColors.primaryColor,
        ),
        // borderRadius: BorderRadius.circular(15)
      ),
    ),
  );
}
