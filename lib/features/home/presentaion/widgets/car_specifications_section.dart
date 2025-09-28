import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class CarSpecificationsSection extends StatelessWidget {
  final int year;
  final String transmission;
  final String engine;
  final String fuelType;
  final String color;
  final int doors;

  const CarSpecificationsSection({
    super.key,
    required this.year,
    required this.transmission,
    required this.engine,
    required this.fuelType,
    required this.color,
    required this.doors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(20.w),
      color: isDark ? const Color(0xFF2A2A2A) : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Car Specifications',
            style: AppTextStyles.s18w700.copyWith(
              color: isDark ? Colors.white : AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),

          // Specifications Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.2,
            children: [
              _buildSpecificationCard(
                icon: Icons.calendar_today,
                label: 'Year',
                value: year.toString(),
                isDark: isDark,
              ),
              _buildSpecificationCard(
                icon: Icons.settings,
                label: 'Transmission',
                value: transmission,
                isDark: isDark,
              ),
              _buildSpecificationCard(
                icon: Icons.build,
                label: 'Engine',
                value: engine,
                isDark: isDark,
              ),
              _buildSpecificationCard(
                icon: Icons.local_gas_station,
                label: 'Fuel Type',
                value: fuelType,
                isDark: isDark,
              ),
              _buildSpecificationCard(
                icon: Icons.palette,
                label: 'Color',
                value: color,
                isDark: isDark,
              ),
              _buildSpecificationCard(
                icon: Icons.door_front_door,
                label: 'Doors',
                value: doors.toString(),
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationCard({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3A3A3A) : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? Colors.white12 : AppColors.gray.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Icon(
            icon,
            size: 24.sp,
            color: AppColors.primary,
          ),
          SizedBox(height: 8.h),

          // Label
          Text(
            label,
            style: AppTextStyles.s12w400.copyWith(
              color: isDark ? Colors.white70 : AppColors.gray,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Value
          Text(
            value,
            style: AppTextStyles.s14w500.copyWith(
              color: isDark ? Colors.white : AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
