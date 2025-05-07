import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/app_type_card.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/top_section_auth.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/services/locator_service.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_theme.dart';
import '../../../../core/utiles/validator.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/custom_app_snack_bar.dart';
import '../widgets/resend_timer_widget.dart';

class VerifyForgetPasswordPage extends StatefulWidget {
  const VerifyForgetPasswordPage({super.key, required this.phonNumber});

  final int phonNumber;

  @override
  State<VerifyForgetPasswordPage> createState() =>
      _VerifyForgetPasswordPageState();
}

class _VerifyForgetPasswordPageState extends State<VerifyForgetPasswordPage> {
  VerifycodeParams params = VerifycodeParams();
  final formState = GlobalKey<FormState>();

  @override
  void initState() {
    params.phoneNumber = widget.phonNumber;
    // params.email = "mutfaismail123@gmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            spacing: 30.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopSectionAuth(
                headline: 'Check Your Message',
                description:
                    'We Already Sent You 4 Digit OTP Number ToYour Phone Number *********46',
              ),
              Center(
                child: Pinput(
                  defaultPinTheme: AppThemes.pinTheme(context),
                  onChanged: (value) {
                    params.otp = value;
                  },
                  validator: (value) => Validator.notNullValidation(value),
                ),
              ),
              TimerWidget(),

              VerifyOtpButtonWidget(formState: formState, params: params),
              ResendTimerWidget(phoneNumber: params.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyOtpButtonWidget extends StatelessWidget {
  const VerifyOtpButtonWidget({
    super.key,
    required this.formState,
    required this.params,
  });

  final GlobalKey<FormState> formState;
  final VerifycodeParams params;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.checkAuthState == CheckAuthState.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customAppSnackBar("Reset code is valid.", context));
          // context.push(
          //   PagesNames.newPasswordPage.route,
          //   extra: BlocProvider.of<AuthCubit>(context),
          // );
        } else if (state.checkAuthState == CheckAuthState.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customAppSnackBar(state.error ?? "", context));
        }
      },
      bloc: getItInstance<AuthCubit>(),
      builder: (context, state) {
        if (state.checkAuthState == CheckAuthState.isLoading) {
          return const CircularProgressIndicator(color: AppColors.primaryColor);
        }
        return AuthButton(onTap: () {
          context.go(RouteNames.createNewPasswordPage);
        }, buttonText: 'Continue');
      },
    );
  }
}

class VerifycodeParams {
  late int phoneNumber;
  String otp = '';
}
