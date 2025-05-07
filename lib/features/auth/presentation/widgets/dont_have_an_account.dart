
import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_texts_styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Didn’t Have Account?',
          style: AppTextStyles.blackS18W400WithOp,
        ),
        const SizedBox(width: 3),
        InkWell(
          onTap: () {
            context.go(RouteNames.rigesterScreen);
          },
          child: Text(
            'Register',
            style:AppTextStyles.blackS18W700
          ),
        ),
      ],
    );
  }
}
