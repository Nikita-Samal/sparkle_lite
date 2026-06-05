import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';
import 'package:sparkle_lite/features/health_timeline/presentation/pages/health_timeline_page.dart';
import 'package:sparkle_lite/features/ai_health_insight/presentation/pages/ai_health_insight_page.dart';
import 'package:sparkle_lite/features/doctor_visit/presentation/pages/doctor_visit_preparation_page.dart';

import 'package:sparkle_lite/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sparkle_lite/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:sparkle_lite/features/dashboard/presentation/bloc/dashboard_state.dart';



class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(LoadDashboardEvent()),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreeting(),
                      SizedBox(height: 20.h),

                      _buildNextReminder(),

                      SizedBox(height: 16.h),

                      _buildCard(
                        title: "Recent Symptom Log",
                        subtitle: "No symptoms logged today",
                        icon: Icons.monitor_heart_outlined,
                      ),

                      SizedBox(height: 12.h),

                      _buildCard(
                        title: "Recent Report",
                        subtitle: "No reports uploaded",
                        icon: Icons.description_outlined,
                      ),

                      SizedBox(height: 12.h),

                      _buildCard(
                        title: "Latest AI Insight",
                        subtitle: "No insights generated yet",
                        icon: Icons.psychology_outlined,
                      ),

                      SizedBox(height: 20.h),

                      _buildTimelineCard(context),

                      SizedBox(height: 24.h),

                      Text(
                        "Quick Actions",
                        style: AppTextStyles.heading3,
                      ),

                      SizedBox(height: 12.h),

                      _buildQuickActions(context),

                      SizedBox(height: 24.h),

                      Text(
                        "Recent Activity",
                        style: AppTextStyles.heading3,
                      ),

                      SizedBox(height: 12.h),

                      _buildCard(
                        title: "Activity",
                        subtitle: "No recent activity available",
                        icon: Icons.history,
                      ),
                    ],
                  ),
                ),

                if (state.isLoading)
                  Container(
                    color: Colors.black12,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good Morning 👋",
          style: AppTextStyles.heading2,
        ),
        SizedBox(height: 4.h),
        Text(
          "Track and manage your health journey",
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildNextReminder() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: AppColors.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "Next Reminder: Log symptoms at 8:00 PM",
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
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
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 28.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HealthTimelinePage(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.timeline,
              color: AppColors.primary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Timeline",
                    style: AppTextStyles.bodyLarge,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "View your complete health history",
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      children: [
        _actionTile(
          context,
          title: "Log Symptom",
          icon: Icons.edit_note,
        ),
        _actionTile(
          context,
          title: "Upload Report",
          icon: Icons.upload_file,
        ),
        _actionTile(
          context,
          title: "Doctor Visit",
          icon: Icons.medical_services_outlined,
        ),
        _actionTile(
          context,
          title: "Ask AI",
          icon: Icons.psychology_outlined,
        ),
      ],
    );
  }

  Widget _actionTile(
      BuildContext context, {
        required String title,
        required IconData icon,
      }) {
    return InkWell(
      onTap: () {
        if (title == "Ask AI") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AiHealthInsightPage(),
            ),
          );
        }

        if (title == "Doctor Visit") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DoctorVisitPreparationPage(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 28.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: AppTextStyles.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}