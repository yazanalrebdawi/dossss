import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/core/services/locator_service.dart';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:dooss_business_app/features/auth/data/models/create_account_params_model.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/phone_field.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/top_section_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utiles/validator.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/custom_app_snack_bar.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final ForgetPasswordParams _phoneNumber = ForgetPasswordParams();

  @override
  Widget build(BuildContext contextOfBuild) {
    return BlocProvider(
      create: (context) => getItInstance<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                TopSectionAuth(
                  headline: 'Forget Password?',
                  description:
                      'Please Input Your Phone Number To Recover Your Dooss Account',
                ),
                 // SizedBox(height: 5.h),
                Text('Phone Number',style: AppTextStyles.lableTextStyleBlackS22W500,),
                PhoneField(
                  onPhoneNumberSelected: (onPhoneNumberSelected) {
                    _phoneNumber.phoneNumber = onPhoneNumberSelected;
                  },
                  validator:
                      (phone) => Validator.notNullValidation(phone?.number),
                ),
                 // SizedBox(height: 10.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    switch (state.checkAuthState) {
                      case CheckAuthState.error:
                        ScaffoldMessenger.of(context).showSnackBar(
                          customAppSnackBar(state.error ?? "", context),
                        );
                        break;
                      default:
                        break;
                    }
                  },
                  builder: (context, state) {
                    if (state.checkAuthState == CheckAuthState.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    return AuthButton(
                      onTap: () {
                        context.go(RouteNames.verifyForgetPasswordPage);
                      },

                      buttonText: 'Recover Account',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
