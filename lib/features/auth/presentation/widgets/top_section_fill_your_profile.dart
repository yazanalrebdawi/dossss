import 'package:dooss_business_app/core/style/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';


class PickYourProfileImageWidget extends StatefulWidget {
  const PickYourProfileImageWidget({super.key, required this.onImagePicked});
final void Function(String) onImagePicked;
  @override
  State<PickYourProfileImageWidget> createState() => _PickYourProfileImageWidgetState();
}

class _PickYourProfileImageWidgetState extends State<PickYourProfileImageWidget> {
  String? image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(Icons.access_alarm)
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: GestureDetector(
              onTap: () {
                widget.onImagePicked(image ?? '');
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primaryColor,
                child:Icon(Icons.access_alarm_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
