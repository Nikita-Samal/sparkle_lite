import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class DoctorVisitPreparationPage extends StatefulWidget {
  DoctorVisitPreparationPage({super.key});

  @override
  State<DoctorVisitPreparationPage> createState() =>
      _DoctorVisitPreparationPageState();
}

class _DoctorVisitPreparationPageState
    extends State<DoctorVisitPreparationPage> {
  bool isSummaryGenerated = false;

  final notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBarWidget(
        title: "Doctor Visit Preparation",
        showBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _section(
                      "Profile Basics",
                      "Age: 28\nLife Stage: General Wellness",
                    ),

                    SizedBox(height: 12.h),

                    _section(
                      "Recent Symptoms",
                      "Lower abdominal pain\nMood changes",
                    ),

                    SizedBox(height: 12.h),

                    _section(
                      "Period History",
                      "Last period started on 20 Jul 2026",
                    ),

                    SizedBox(height: 12.h),

                    _section(
                      "Uploaded Records",
                      "Blood Test Report\nPrescription",
                    ),

                    SizedBox(height: 12.h),

                    _section(
                      "Current Medications",
                      "Iron Supplements",
                    ),

                    SizedBox(height: 12.h),

                    _section(
                      "Questions To Ask Doctor",
                      "• Why is pain recurring?\n"
                          "• Are additional tests needed?",
                    ),

                    SizedBox(height: 12.h),

                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Additional Notes",
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    if (isSummaryGenerated)
                      _buildGeneratedSummary(),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    isSummaryGenerated = true;
                  });
                },
                child: Text(
                  "Generate Summary",
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(
      String title,
      String value,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3,
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedSummary() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generated Summary",
            style: AppTextStyles.heading3,
          ),

          SizedBox(height: 10.h),

          Text(
            "Summary generated on today's date.\n\n"
                "Includes profile details, symptoms, period history, "
                "records, medications and doctor questions.",
            style: AppTextStyles.bodyMedium,
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          "Summary saved to timeline",
                        ),
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          "Summary copied",
                        ),
                      ),
                    );
                  },
                  child: Text("Copy"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}