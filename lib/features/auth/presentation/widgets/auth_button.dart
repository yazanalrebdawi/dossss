import 'package:dooss_business_app/core/style/app_colors.dart';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;



  const AuthButton({
    super.key,
    required this.onTap,
    required this.buttonText,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: GestureDetector(
        child: Container(
          height: 70.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(26.r),
          ),
          padding: EdgeInsets.all(10.r),
          child: Center(
            child: Text(
              buttonText,
              style: AppTextStyles.buttonTextStyleWhiteS22W700,
            ),
          ),
        ),
      ),
    );
  }
}
