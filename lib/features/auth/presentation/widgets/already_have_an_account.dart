import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/style/app_texts_styles.dart';

class AlreadyHaveAccount extends StatelessWidget {

  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an Account?',
          style: AppTextStyles.hintTextStyleWhiteS20W400,
        ),
        const SizedBox(width: 3),
        InkWell(
          onTap: () {
            context.go(RouteNames.loginScreen);
          },
          child: Text(
            'Login',
            style: AppTextStyles.blackS18W700,
          ),
        ),
      ],
    );
  }
}
