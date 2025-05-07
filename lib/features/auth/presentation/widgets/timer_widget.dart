import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../core/style/app_texts_styles.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds = 60;

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        setState(
              () {
            if (seconds > 0) {
              seconds--;
            } else {
              timer.cancel();
            }
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            "00:${seconds.toString().padLeft(2, '0')}",
            style: AppTextStyles.descriptionBoardingBlackS18W500,
            ),
      );
   }
}