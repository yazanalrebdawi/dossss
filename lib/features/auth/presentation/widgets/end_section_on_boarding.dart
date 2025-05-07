import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_names.dart';
import 'custom_floating_action_button.dart';

class EndSectionOnBoarding extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final PageController controller;
  final bool isLast;
  final String routeNames;

  const EndSectionOnBoarding({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.controller, required this.isLast, required this.routeNames,
  });

  @override
  State<EndSectionOnBoarding> createState() => _EndSectionOnBoardingState();
}

class _EndSectionOnBoardingState extends State<EndSectionOnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${widget.currentPage}/${widget.totalPages}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        CustomFloatingActionButton(
          onTap: () {
            setState(() {
              if (widget.isLast == true) {
                context.go(widget.routeNames);
              }
              widget.controller.nextPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.fastEaseInToSlowEaseOut,
              );
            });
          },
        ),
      ],
    );
  }
}
