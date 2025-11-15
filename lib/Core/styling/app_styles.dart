import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Core/styling/app_colors.dart';
import 'package:movie_app/Core/styling/app_fonts.dart';

class AppStyles {
  static TextStyle primaryHeadLinesStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 26.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.blackColor,
  );

  static TextStyle primary24HeadStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static TextStyle subtitles16Styles = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryColor,
  );

  static TextStyle subtitles12Styles = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryColor,
  );

  static TextStyle black16w500Style = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static TextStyle grey10w500Style = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.greyColor,
  );

  static TextStyle grey12MediumStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.greyColor,
  );
  static TextStyle grey12NormalMediumStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.greyColor,
  );
  static TextStyle black15BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle black18BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
