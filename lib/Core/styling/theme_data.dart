import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:movie_app/Core/styling/app_colors.dart';
import 'package:movie_app/Core/styling/app_fonts.dart';
import 'package:movie_app/Core/styling/app_styles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.zoom,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.mainFontName,
    textTheme: TextTheme(
      titleLarge: AppStyles.primaryHeadLinesStyle,
      titleMedium: AppStyles.subtitles16Styles,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),
  );
  static final darktheme = ThemeData(
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.zoom,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Color.fromARGB(0, 5, 0, 7),

    fontFamily: AppFonts.mainFontName,
    textTheme: TextTheme(
      titleLarge: AppStyles.primaryHeadLinesStyle,
      titleMedium: AppStyles.subtitles16Styles,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),
  );
}
