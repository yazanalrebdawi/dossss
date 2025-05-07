import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/top_section_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/locator_service.dart';
import '../../../../core/style/app_texts_styles.dart';
import '../../../../core/utiles/validator.dart';
import '../../data/models/create_account_params_model.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

import '../widgets/suffix_icon_pass.dart';

class CreateNewPasswordPage extends StatelessWidget {
  final SigninParams _params = SigninParams();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode confermNode = FocusNode();

  void dispose() {
    _params.paramsDispose();
    confermNode.dispose();
    confirmPasswordController.dispose();
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getItInstance<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _params.formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopSectionAuth(
                  headline: 'Create New Password',
                  description:
                      'Please Create New Password Of Your\n Dooss Account To Access Again To\n Your Account',
                ),
                SizedBox(height: 38.h),
                Text(
                  'Password',
                  style: AppTextStyles.lableTextStyleBlackS22W500,
                ),
                SizedBox(height: 9.h),
                TextFormField(
                  controller: _params.password,
                  focusNode: _params.passwordNode,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelStyle: AppTextStyles.headLineBoardingBlackS25W700,

                    suffixIcon: SuffixIconPass(),
                  ),
                  validator: (passsword) {
                    return Validator.validatePass(passsword);
                  },
                  onFieldSubmitted:
                      (value) =>
                          FocusScope.of(context).requestFocus(confermNode),
                ),
                SizedBox(height: 26.h),
                Text(
                  'ReType Password',
                  style: AppTextStyles.lableTextStyleBlackS22W500,
                ),
                SizedBox(height: 9.h),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: confirmPasswordController,
                      focusNode: confermNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'ReType Password',
                        labelStyle: AppTextStyles.headLineBoardingBlackS25W700,

                        suffixIcon: SuffixIconPass(),
                      ),
                      validator: (conPass) {
                        if (conPass == _params.password.text) {
                          return null;
                        } else {
                          return "The Password isn't valid";
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 55.h),
                AuthButton(onTap: () {
                  context.go(RouteNames.loginScreen);
                }, buttonText: 'Confirm Password'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
