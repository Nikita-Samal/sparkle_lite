import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class PrivacySettingsPage extends StatefulWidget {
  PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() =>
      _PrivacySettingsPageState();
}

class _PrivacySettingsPageState
    extends State<PrivacySettingsPage> {

  bool hideSensitiveDashboardDetails = true;
  bool genericNotifications = true;
  bool detailedNotifications = false;
  bool confirmBeforeSharing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          "Privacy Settings",
          style: AppTextStyles.heading3,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildSwitchTile(
              title: "Hide Sensitive Dashboard Details",
              subtitle:
              "Hide period, symptom and health information on dashboard",
              value: hideSensitiveDashboardDetails,
              onChanged: (value) {
                setState(() {
                  hideSensitiveDashboardDetails = value;
                });
              },
            ),

            _buildSwitchTile(
              title: "Use Generic Notification Text",
              subtitle:
              "Notifications will not reveal health information",
              value: genericNotifications,
              onChanged: (value) {
                setState(() {
                  genericNotifications = value;
                });
              },
            ),

            _buildSwitchTile(
              title: "Allow Detailed Notification Text",
              subtitle:
              "Show detailed health reminders in notifications",
              value: detailedNotifications,
              onChanged: (value) {
                setState(() {
                  detailedNotifications = value;
                });
              },
            ),

            _buildSwitchTile(
              title: "Require Confirmation Before Sharing Records",
              subtitle:
              "Ask before sharing reports or visit summaries",
              value: confirmBeforeSharing,
              onChanged: (value) {
                setState(() {
                  confirmBeforeSharing = value;
                });
              },
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Privacy settings saved",
                      ),
                    ),
                  );
                },
                child: Text(
                  "Save Settings",
                  style: AppTextStyles.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: AppTextStyles.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall,
        ),
      ),
    );
  }
}