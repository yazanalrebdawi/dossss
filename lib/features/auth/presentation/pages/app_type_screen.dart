import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/language_cubit.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/services/auth_service.dart';

import '../widgets/app_type_card.dart';

class AppTypeScreen extends StatefulWidget {
  const AppTypeScreen({super.key});

  @override
  State<AppTypeScreen> createState() => _AppTypeScreenState();
}

class _AppTypeScreenState extends State<AppTypeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    print('🔍 AppTypeScreen - Checking authentication...');
    final isAuthenticated = await AuthService.isAuthenticated();
    print('🔍 AppTypeScreen - Is authenticated: $isAuthenticated');
    
    if (isAuthenticated && mounted) {
      print('🚀 AppTypeScreen - User is authenticated, navigating to Home');
      context.go(RouteNames.homeScreen);
    } else {
      print('🔍 AppTypeScreen - User is not authenticated, staying on app type screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return Text(
                AppLocalizations.of(context)?.translate('appType') ?? 'App Type',
                style: AppTextStyles.blackS18W500,
              );
            },
          ),
          actions: [
            // Language Toggle Button
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LanguageCubit>().toggle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    ),
                    child: Text(
                      locale.languageCode == 'ar' ? 'EN' : 'عربي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
                    BlocBuilder<LanguageCubit, Locale>(
                      builder: (context, locale) {
                        return Text(
                          AppLocalizations.of(context)?.translate('chooseAccountType') ?? 'Choose The Account Type',
                          style: AppTextStyles.blackS25W500,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    SizedBox(height: 90.h),

                    BlocBuilder<LanguageCubit, Locale>(
                      builder: (context, locale) {
                        return AppTypeButton(
                          onTap: () {
                            context.push(RouteNames.loginScreen);
                          },
                          buttonText: AppLocalizations.of(context)?.translate('personalAccount') ?? 'Personal Account',
                          buttonColor: AppColors.secondary,
                          textStyle: AppTextStyles.blackS18W700,
                        );
                      },
                    ),
                    SizedBox(height: 22.h),
                    BlocBuilder<LanguageCubit, Locale>(
                      builder: (context, locale) {
                        return AppTypeButton(
                          onTap: () {
                            context.go(RouteNames.loginScreen);
                          },
                          buttonText: AppLocalizations.of(context)?.translate('businessAccount') ?? 'Business Account',
                          buttonColor: AppColors.primary,
                          textStyle: AppTextStyles.whiteS18W700,
                        );
                      },
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
