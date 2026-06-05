import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class AiHealthInsightPage extends StatefulWidget {
  AiHealthInsightPage({super.key});

  @override
  State<AiHealthInsightPage> createState() =>
      _AiHealthInsightPageState();
}

class _AiHealthInsightPageState
    extends State<AiHealthInsightPage> {
  bool isGenerated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBarWidget(
        title:"AI Health Insight",
        showBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildRecentLogsCard(),

            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isGenerated = true;
                  });
                },
                child: Text(
                  "Generate Insight",
                  style: AppTextStyles.buttonText,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: isGenerated
                  ? _buildInsightResult()
                  : _buildEmptyState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogsCard() {
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
            "Selected Recent Logs",
            style: AppTextStyles.heading3,
          ),

          SizedBox(height: 10.h),

          Text(
            "• Lower abdominal pain",
            style: AppTextStyles.bodyMedium,
          ),

          Text(
            "• Irregular bleeding",
            style: AppTextStyles.bodyMedium,
          ),

          Text(
            "• Mood changes",
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightResult() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _sectionCard(
            "Plain-language Summary",
            "Your recent logs show recurring pain and irregular bleeding patterns.",
          ),

          SizedBox(height: 12.h),

          _sectionCard(
            "Possible Pattern Noticed",
            "Symptoms appear multiple times during the last few weeks.",
          ),

          SizedBox(height: 12.h),

          _sectionCard(
            "Suggested Doctor Questions",
            "• Could these symptoms be related?\n"
                "• Should any additional tests be considered?\n"
                "• What symptoms should be monitored?",
          ),

          SizedBox(height: 12.h),

          _sectionCard(
            "When To Seek Care",
            "Consider seeking medical advice if symptoms become severe, frequent, or interfere with daily activities.",
          ),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              "This insight is not a diagnosis and should not replace professional medical advice.",
              style: AppTextStyles.bodyMedium,
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Insight saved to timeline",
                    ),
                  ),
                );
              },
              child: Text(
                "Save To Timeline",
                style: AppTextStyles.buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
      String title,
      String description,
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
            description,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        "Generate an insight from recent symptom logs",
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}