import 'package:dooss_business_app/core/routes/route_names.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/end_section_on_boarding.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/second_register_body_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/locator_service.dart';
import '../manager/auth_cubit.dart';
import '../widgets/already_have_an_account.dart';
import '../widgets/first_register_body_section.dart';
import 'final_step_register_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

  List<Widget> registerScreenBodies = [
    FirstRegisterBodySection(),
    SecondRegisterBodySection(),
  ];

  int currentPage = 1;
  int totalPages = 3;
  bool isLast = false;
  PageController boardController = PageController();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == widget.registerScreenBodies.length - 1) {
                      widget.isLast = true;
                    }
                    setState(() {
                      widget.currentPage = index + 1;
                    });
                  },
                  physics: BouncingScrollPhysics(),
                  controller: widget.boardController,
                  itemCount: widget.registerScreenBodies.length,
                  itemBuilder: (context, index) {
                    widget.currentPage = index + 1;
                    return widget.registerScreenBodies[index];
                  },
                ),
              ),

              EndSectionOnBoarding(
                routeNames: RouteNames.thirdRegisterBodySection,
                currentPage: widget.currentPage,
                totalPages: widget.totalPages,
                controller: widget.boardController,
                isLast: widget.isLast,
              ),
              SizedBox(height: 25.h),
              AlreadyHaveAccount(),
              SizedBox(height: 50.h),

            ],
          ),
        ),
      ),
    );
  }
}
