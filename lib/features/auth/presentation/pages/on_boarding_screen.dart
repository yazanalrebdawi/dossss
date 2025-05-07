import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/core/style/app_assets.dart';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/custom_floating_action_button.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/end_section_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(RouteNames.selectAppTypeScreen);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go(RouteNames.loginScreen);
            },
            child: Text('Skip', style: AppTextStyles.blackS20W500),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 125.h),
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boardingBodies.length - 1) {
                    isLast = true;
                  }
                  setState(() {
                    currentPage = index + 1;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemCount: boardingBodies.length,
                itemBuilder: (context, index) {
                  currentPage = index + 1;
                  return BuildOnBoarding(boardingBodies[index]);
                },
              ),
            ),
            EndSectionOnBoarding(
              routeNames: RouteNames.loginScreen,
              currentPage: currentPage,
              totalPages: totalPages,
              controller: boardController,
              isLast: isLast,
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildOnBoarding(BoardingModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(data.img)),
        SizedBox(height: 80.h),
        Text(data.headline, style: AppTextStyles.headLineBoardingBlackS25W700),
        SizedBox(height: 10.h),
        Text(
          data.description,
          style: AppTextStyles.descriptionBoardingBlackS18W500,
        ),

      ],
    );
  }

  PageController boardController = PageController();
  List<BoardingModel> boardingBodies = [
    BoardingModel(
      AppAssets.onBoardingImage1,
      ' Endless Option',
      'Choose of hundred of models you won’t find anywhere else. pick it up or get it delivered where you want it.',
    ),
    BoardingModel(
      AppAssets.onBoardingImage2,
      'Drive Confidently',
      'Drive Confidently With Your Choice Of Protection Plans. All Plans Include Varying Level Of Insurance From Ibrahim Insurance',
    ),
    BoardingModel(
      AppAssets.onBoardingImage3,
      '24/7 Support',
      'Rest Easy Knowing That Everyone In Premium Community Is Screened And Support Road A side Assistance',
    ),
  ];
  int currentPage = 1;
  int totalPages = 3;
  bool isLast = false;
}
