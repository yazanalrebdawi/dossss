import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/app_type_card.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/suffix_icon_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/utiles/validator.dart';
import '../../data/models/create_account_params_model.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import 'custom_app_snack_bar.dart';

class LogInBodySection extends StatefulWidget {
  const LogInBodySection({super.key});

  @override
  State<LogInBodySection> createState() => _LogInBodySectionState();
}

class _LogInBodySectionState extends State<LogInBodySection> {
  final SigninParams _params = SigninParams();

  @override
  void dispose() {
    _params.paramsDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _params.formState,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Email Address',style: AppTextStyles.lableTextStyleBlackS22W500,),
            TextFormField(
              controller: _params.email,
              focusNode: _params.emailNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Your Email Address",
              ),
              validator: (value) {
                return Validator.emailValidation(value);
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_params.passwordNode);
              },
            ),
          SizedBox(height: 20.h,),
          Text('Password',style: AppTextStyles.lableTextStyleBlackS22W500,),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return TextFormField(
                  controller: _params.password,
                  focusNode: _params.passwordNode,
                  obscureText: state.isObscurePassword ?? false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Your Password",
                    labelStyle: AppTextStyles.headLineBoardingBlackS25W700,
                    // labelText: 'Password',
                    suffixIcon: SuffixIconPass(),
                  ),
                  validator: (value) {
                    return Validator.validatePass(value);
                  },
                );
              },
            ),
            SizedBox(height: 15.h,),

            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.checkAuthState == CheckAuthState.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(customAppSnackBar("${state.error}", context));
                }
              },
              builder: (context, state) {
                if (state.checkAuthState == CheckAuthState.isLoading) {
                  return const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  );
                }
                return AuthButton(
                  onTap: () {
                    if (_params.formState.currentState!.validate()) {
                      context.read<AuthCubit>().signIn(_params);
                    }
                  },
                  buttonText: 'Log In',

                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                  context.go(RouteNames.forgetPasswordPage);
                  },
                  child: Text(
                    'ForgetPassword?',
                    style: AppTextStyles.blackS18W400WithOp
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


