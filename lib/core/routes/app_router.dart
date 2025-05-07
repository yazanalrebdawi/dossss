
import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:dooss_business_app/features/auth/presentation/pages/create_new_password_screen.dart';
import 'package:dooss_business_app/features/auth/presentation/pages/register_screen.dart';
import 'package:dooss_business_app/features/auth/presentation/pages/verify_forget_password_screen.dart';

import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/log_in_screen.dart';
import '../../features/auth/presentation/pages/app_type_screen.dart';
import '../../features/auth/presentation/pages/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/final_step_register_screen.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteNames.selectAppTypeScreen,
        builder: (context,state) => AppTypeScreen(),
      ),
      GoRoute(
        path: RouteNames.onboardingScreen,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: RouteNames.loginScreen,
        builder: (context, state) => LogInScreen(),
      ),
      GoRoute(
        path: RouteNames.rigesterScreen,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgetPasswordPage,
        builder: (context, state) => ForgetPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.verifyForgetPasswordPage,
        builder: (context, state) => VerifyForgetPasswordPage(phonNumber: 0999999,),
      ),
      GoRoute(
        path: RouteNames.createNewPasswordPage,
        builder: (context, state) => CreateNewPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.thirdRegisterBodySection,
        builder: (context, state) => FinalStepRegisterScreen(),
      ),

    ],
  );
}