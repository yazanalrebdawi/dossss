import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../../core/style/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onTap;

  const CustomFloatingActionButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67.h,
      height: 67.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: GradientBoxBorder(
          width: 2,
          gradient: LinearGradient(
            colors: [AppColors.endGradientColor, AppColors.startGradientColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: GradientRotation(1),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor, width: 2),
          borderRadius: BorderRadius.circular(100),
        ), // margin: EdgeInsets.all(5),
        child: CircleAvatar(
          radius: 33.5.r,
          backgroundColor: AppColors.buttonColor,
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward,
              size: 29,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
