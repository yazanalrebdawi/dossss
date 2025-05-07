import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSectionAuth extends StatelessWidget {
  final String headline;
  final String description;
  const TopSectionAuth({super.key, required this.headline, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headline,style:AppTextStyles.lableTextStyleBlackS22W500 ,),
          SizedBox(height: 5.h),
          Text(
            description,
            style:AppTextStyles.descriptionBoardingBlackS18W500,
          ),
        ],
      ),
    );
  }
}
