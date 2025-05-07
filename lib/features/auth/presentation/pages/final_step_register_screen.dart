import 'dart:io';
import 'package:dooss_business_app/core/style/app_texts_styles.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/already_have_an_account.dart';
import 'package:dooss_business_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../../core/style/app_colors.dart';

//
class FinalStepRegisterScreen extends StatefulWidget {
  const FinalStepRegisterScreen({super.key});

  @override
  State<FinalStepRegisterScreen> createState() =>
      _FinalStepRegisterScreenState();
}

class _FinalStepRegisterScreenState extends State<FinalStepRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Photo', style: AppTextStyles.headLineBoardingBlackS25W700),
          SizedBox(height: 73.h),
          MultibleImagesPickerWidget(
            deffultWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.photo_camera_outlined),
                Text(
                  'Add Your Photos Here',
                  style: TextStyle(color: AppColors.grayColor),
                ),
              ],
            ),
            height: 173.h,
            imageSelected: (imageSelected) {},
            widgetLabel: 'Add Your Photos Here',
          ),
          SizedBox(height: 20.h),
          MultibleImagesPickerWidget(
            deffultWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.photo_camera_outlined),
                Text(
                  'Add Your Photos Here',
                  style: TextStyle(color: AppColors.grayColor),
                ),
              ],
            ),
            height: 173.h,
            imageSelected: (imageSelected) {},
            widgetLabel: 'Add Your Photos Here',
          ),

          SizedBox(height: 20.h),

          MultibleImagesPickerWidget(
            deffultWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text(
                  'Add More Photos',
                  style: TextStyle(color: AppColors.grayColor),
                ),
              ],
            ),
            height: 62.h,
            imageSelected: (imageSelected) {},
            widgetLabel: 'Add More Photos',
          ),
          SizedBox(height: 79.h),
          AuthButton(onTap: () {}, buttonText: 'Register'),
          SizedBox(height: 25.h),
          AlreadyHaveAccount(),
        ],
      ),
    );
  }
}

class MultibleImagesPickerWidget extends StatefulWidget {
  final Function(List<File>) imageSelected;
  final String widgetLabel;
  final double? height;
  final Widget deffultWidget;

  const MultibleImagesPickerWidget({
    super.key,
    required this.imageSelected,
    required this.widgetLabel,
    this.height,
    required this.deffultWidget,
  });

  @override
  State<MultibleImagesPickerWidget> createState() =>
      _MultibleImagesPickerWidgetState();
}

class _MultibleImagesPickerWidgetState
    extends State<MultibleImagesPickerWidget> {
  final ValueNotifier<List<File>> imagesNotifier = ValueNotifier<List<File>>(
    [],
  );

  Future<void> _pickImages() async {
    final pickedFiles =
        await ImagePickerService.pickMultibleImage(); // Assume this method supports multiple images

    if (pickedFiles.isNotEmpty) {
      imagesNotifier.value =
          pickedFiles.map((file) => File(file!.path)).toList();
      widget.imageSelected(imagesNotifier.value);
    }
  }

  @override
  void dispose() {
    imagesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<List<File>>(
          valueListenable: imagesNotifier,
          builder: (context, imageFiles, child) {
            return GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: widget.height,
                // padding: EdgeInsetsDirectional.symmetric(vertical: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grayColor),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child:
                    imageFiles.isNotEmpty
                        ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageFiles.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  imageFiles[index],
                                  width: 75,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        )
                        : widget.deffultWidget,
              ),
            );
          },
        ),
      ],
    );
  }
}
