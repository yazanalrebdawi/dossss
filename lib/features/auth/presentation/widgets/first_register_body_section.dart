
import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/phone_field.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/log_in_body_section.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/suffix_icon_pass.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/top_section_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_texts_styles.dart';
import '../../../../core/utiles/validator.dart';
import '../../data/models/create_account_params_model.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import 'already_have_an_account.dart';
import 'end_section_on_boarding.dart';



class FirstRegisterBodySection extends StatefulWidget {


  int currentPage = 1;
  int totalPages = 3;
  PageController boardController = PageController();

   FirstRegisterBodySection({super.key});
  @override
  State<FirstRegisterBodySection> createState() => _FirstRegisterBodySectionState();
}
class _FirstRegisterBodySectionState extends State<FirstRegisterBodySection> {
  final CreateAccountParams _params = CreateAccountParams();
  @override
  void dispose() {
    _params.paramsDispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _params.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopSectionAuth(
            headline: 'Nice To Know You ! 😎',
            description: 'It’s Your Frist Time To Use Dooss',
          ),
          SizedBox(height: 20.h),          Text(
            "${"Store Name"} ",
            style: AppTextStyles.lableTextStyleBlackS22W500,
          ),
          SizedBox(height: 9.h),
          TextFormField(
            controller: _params.firstName,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'Your Store Name'),
            validator: (value) => Validator.notNullValidation(value),
          ),
          Text(
            "${"Email Address"} ",
            style: AppTextStyles.lableTextStyleBlackS22W500,
          ),

          SizedBox(height: 9.h),

          TextFormField(
            controller: _params.nickName,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'Your Email Address'),
            validator: (value) => Validator.notNullValidation(value),
          ),
          Text(
            "${"Password"}",
            style: AppTextStyles.lableTextStyleBlackS22W500,
          ),
          SizedBox(height: 9.h),

          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return TextFormField(
                controller: _params.password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: state.isObscurePassword ?? false,
                validator: (value) => Validator.validatePass(value),
                decoration: InputDecoration(
                  hintText: 'Your Password',
                  suffixIcon: const SuffixIconPass(),
                ),
              );
            },
          ),
          Text(
            "${"Phone Number"}",
            style: AppTextStyles.lableTextStyleBlackS22W500,
          ),
          SizedBox(height: 9.h),

          PhoneField(
            onPhoneNumberSelected: (onPhoneNumberSelected) {
              _params.phoneNumber = onPhoneNumberSelected;
            },
            validator: (phone) => Validator.notNullValidation(phone?.number),
          ),
          SizedBox(height: 38.h),


        ],
      ),
    );
  }
}