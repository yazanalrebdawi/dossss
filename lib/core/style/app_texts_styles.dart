


import 'package:dooss_business_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles{

  static TextStyle whiteS18W700 =  TextStyle(
   color: Colors.white,
    fontFamily: 'SFProDisplay',
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle blackS18W700 =  TextStyle(
   color: Colors.black,
    fontFamily: 'SFProDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static TextStyle BlackS25W700 =  TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static TextStyle blackS25W500 = const TextStyle(
    color: Colors.black,
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );
  static TextStyle blackS18W500 = const TextStyle(
    color: Colors.black,
    fontFamily: 'SFProDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle blackS20W500 = const TextStyle(
    color: Colors.black,
    fontFamily: 'SFProDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headLineBoardingBlackS25W700 =  TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static TextStyle lableTextStyleBlackS22W500 =  TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headLineBoardingBlackS22W700 =  TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static TextStyle descriptionBoardingBlackS18W500 =  TextStyle(
    color: Colors.black.withOpacity(0.3),
    fontFamily: 'SFProDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static TextStyle blackS18W400WithOp =  TextStyle(
    color: Colors.black.withOpacity(0.3),
    fontFamily: 'SFProDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static TextStyle descriptionBoardingBlackS15W500 =  TextStyle(
    color: Colors.black.withOpacity(0.3),
    fontFamily: 'SFProDisplay',
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttonTextStyleWhiteS22W700 =  TextStyle(
    color: Colors.white,
    fontFamily: 'SFProDisplay',
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle hintTextStyleWhiteS20W400 =  TextStyle(
    color: AppColors.hintColor.withOpacity(0.5),
    fontFamily: 'SFProDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );



}