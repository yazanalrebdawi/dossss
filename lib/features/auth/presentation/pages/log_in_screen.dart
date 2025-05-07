import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/locator_service.dart';
import '../../../../core/style/app_texts_styles.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/custom_app_snack_bar.dart';
import '../widgets/dont_have_an_account.dart';
import '../widgets/log_in_body_section.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ! it is need to remove
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => getItInstance<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.checkAuthState == CheckAuthState.signinSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(customAppSnackBar("Sign in Success", context));
            Future.delayed(const Duration(seconds: 1), () {});
            // context.go(RouteNames.);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.go(RouteNames.onboardingScreen);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            // EdgeInsets.symmetric(horizontal: width * horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    'Welcome To,Dooss 😊',
                    style: AppTextStyles.headLineBoardingBlackS25W700,
                  ),
                  Text(
                    'Enter Your Account To Continue',
                    style: AppTextStyles.descriptionBoardingBlackS18W500,
                  ),
                  SizedBox(height: 60.h),
                  const LogInBodySection(),
                  SizedBox(height: 38.h),
                  const DontHaveAnAccount(),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
