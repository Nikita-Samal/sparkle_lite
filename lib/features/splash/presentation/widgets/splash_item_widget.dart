import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';
import 'package:sparkle_lite/core/theme/app_theme.dart';


class SplashItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const SplashItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [

              Image.asset(
                image,
                height: 320.h,
                width: 320.w,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 40.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.white,
                ),
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}