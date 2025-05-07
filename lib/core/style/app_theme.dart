import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import 'app_colors.dart';


class AppThemes {
  static final ThemeData _lightTheme = ThemeData.light().copyWith(

    cardTheme: const CardTheme(
      color: AppColors.primaryColor,
      elevation: 3,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    ),
    // ############ Scaffold Theme ###################
    scaffoldBackgroundColor: AppColors.whiteColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    radioTheme: RadioThemeData(
      splashRadius: 26,
    ),

    switchTheme: const SwitchThemeData(),
    // ############ Field Theme ###################
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.hintTextStyleWhiteS20W400,
      filled: true,
      fillColor: AppColors.fieldColor,
      border: OutlineInputBorder(
         borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    // ############ Circler Indecator ###################
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    // ############ Field Theme ###################
  );

  static PinTheme pinTheme(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return PinTheme(
        height: 54.h,
        width: 64.w,
        textStyle: TextStyle(fontSize: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5.r,color: AppColors.grayColor),
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),

        ),
      );
    } else {
      return const PinTheme(
        height: 60,
        width: 60,
        textStyle: TextStyle(fontSize: 20, color: Colors.white),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor,
              blurRadius: 5,
              spreadRadius: 0.01,
            ),
          ],
        ),
      );
    }
  }



  static ThemeData get lightTheme => _lightTheme;
}
