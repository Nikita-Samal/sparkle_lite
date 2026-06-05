import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class NotificationPreferencesPage extends StatefulWidget {
  NotificationPreferencesPage({super.key});

  @override
  State<NotificationPreferencesPage> createState() =>
      _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState
    extends State<NotificationPreferencesPage> {
  bool genericNotification = true;
  bool detailedNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          "Notification Preferences",
          style: AppTextStyles.heading3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            children: [
              SwitchListTile(
                value: genericNotification,
                onChanged: (value) {
                  setState(() {
                    genericNotification = value;
                  });
                },
                title: Text(
                  "Use Generic Notification Text",
                  style: AppTextStyles.bodyLarge,
                ),
                subtitle: Text(
                  "Example: You have a health reminder",
                  style: AppTextStyles.bodySmall,
                ),
              ),

              Divider(height: 1),

              SwitchListTile(
                value: detailedNotification,
                onChanged: (value) {
                  setState(() {
                    detailedNotification = value;
                  });
                },
                title: Text(
                  "Allow Detailed Notification Text",
                  style: AppTextStyles.bodyLarge,
                ),
                subtitle: Text(
                  "Example: Log your symptoms today",
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}