
import 'package:dooss_business_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_texts_styles.dart';

SnackBar customAppSnackBar(String message, BuildContext context) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(15),
    content: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.blackS25W500,
        ),
      ),
    ),
  );
}
