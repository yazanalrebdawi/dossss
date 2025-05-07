import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/core/style/app_assets.dart';
import 'package:dooss_business_app/core/style/app_colors.dart';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_type_card.dart';

class AppTypeScreen extends StatelessWidget {
  const AppTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('App Type', style: AppTextStyles.blackS18W500),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  children: [
                    Text(
                      'Choose The Account \n                 Type',
                      style: AppTextStyles.blackS25W500,
                    ),
                    SizedBox(height: 90.h),

                    AppTypeButton(
                      onTap: () {
                        context.push(RouteNames.onboardingScreen);
                      },
                      buttonText: 'Personal Account',
                      buttonColor: AppColors.secondaryColor,
                      textStyle: AppTextStyles.blackS18W700,
                    ),
                    SizedBox(height: 22.h),
                    AppTypeButton(
                      onTap: () {
                        context.go(RouteNames.onboardingScreen);
                      },
                      buttonText: 'Business Account',
                      buttonColor: AppColors.primaryColor,
                      textStyle: AppTextStyles.whiteS18W700,
                    ),
                  ],
                ),

                SizedBox(),
                Image(image: AssetImage(AppAssets.logoTypeScreen)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
