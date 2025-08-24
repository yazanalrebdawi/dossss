import 'dart:async';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../manager/auth_cubit.dart';

class ResendTimerWidget extends StatefulWidget {
  const ResendTimerWidget({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;
  @override
  State<ResendTimerWidget> createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends State<ResendTimerWidget> {
  int seconds = 60;
  bool isTimerFinished = false;
  _timerPeriodec(int seconds, bool isfinish) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // setState(() {
      //   if (seconds > 0) {
      //     seconds--;
      //   } else {
      //     isfinish = true;

      //     timer.cancel();
      //   }
      // });
    });
  }

  @override
  void initState() {
    _timerPeriodec(seconds, isTimerFinished);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isTimerFinished) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              seconds = 60;
              isTimerFinished = false;
              _timerPeriodec(60, isTimerFinished);
            });
            context.read<AuthCubit>().resetPassword(widget.phoneNumber.toString() );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: Text(
            "Resend",
            style: AppTextStyles.blackS25W700,
          ),
        ),
      );
    } else {
      {
        return Center(
          child: RichText(
            text: TextSpan(
              text: "Didn’t receive the OTP?",
              style: AppTextStyles.descriptionS14W400,
              children: <TextSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=(){},
                  text: "Resend",
                  style: AppTextStyles.primaryS14W400,
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
