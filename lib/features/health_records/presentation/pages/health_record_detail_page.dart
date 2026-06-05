import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';
import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class HealthRecordDetailPage extends StatelessWidget {
  final Map<String, dynamic> record;

  HealthRecordDetailPage({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Record Details",
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: "Report Title",
              value: record["title"] ?? "-",
            ),

            SizedBox(height: 16.h),

            _buildSection(
              title: "Report Type",
              value: record["type"] ?? "-",
            ),

            SizedBox(height: 16.h),

            _buildSection(
              title: "Report Date",
              value: record["date"] ?? "-",
            ),

            SizedBox(height: 16.h),

            _buildSection(
              title: "Doctor / Clinic",
              value: record["doctor"] ?? "Not Provided",
            ),

            SizedBox(height: 16.h),

            _buildSection(
              title: "Notes",
              value: record["notes"] ?? "No Notes Added",
            ),

            SizedBox(height: 24.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.borderColor,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.insert_drive_file_outlined,
                    size: 50.sp,
                    color: AppColors.primary,
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Report Preview",
                    style: AppTextStyles.heading3,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "Mock uploaded file",
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Opening report..."),
                    ),
                  );
                },
                child: Text("View Report"),
              ),
            ),

            SizedBox(height: 12.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton(
                onPressed: () {
                  _showDeleteDialog(context);
                },
                child: Text("Delete Record"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading3,
        ),

        SizedBox(height: 6.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.borderColor,
            ),
          ),
          child: Text(
            value,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Delete Record"),
          content: Text(
            "Are you sure you want to delete this record?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}