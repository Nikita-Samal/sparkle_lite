import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';
import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

import 'package:sparkle_lite/features/health_timeline/presentation/bloc/timeline_bloc.dart';
import 'package:sparkle_lite/features/health_timeline/presentation/bloc/timeline_event.dart';
import 'package:sparkle_lite/features/health_timeline/presentation/bloc/timeline_state.dart';

class HealthTimelinePage extends StatelessWidget {
  HealthTimelinePage({super.key});

  final List<Map<String, dynamic>> timelineItems = [
    {
      "title": "Period Started",
      "date": "20 Jul 2026",
      "type": "Period",
      "description": "Period cycle started.",
      "icon": Icons.water_drop,
    },
    {
      "title": "Symptom Logged",
      "date": "18 Jul 2026",
      "type": "Symptom",
      "description": "Lower abdominal pain recorded.",
      "icon": Icons.monitor_heart_outlined,
    },
    {
      "title": "Lab Report Uploaded",
      "date": "15 Jul 2026",
      "type": "Record",
      "description": "Blood test report uploaded.",
      "icon": Icons.description_outlined,
    },
    {
      "title": "AI Insight Saved",
      "date": "12 Jul 2026",
      "type": "Insight",
      "description": "Recurring pain pattern detected.",
      "icon": Icons.psychology_outlined,
    },
    {
      "title": "Doctor Visit Summary",
      "date": "10 Jul 2026",
      "type": "Doctor",
      "description": "Prepared consultation summary.",
      "icon": Icons.medical_services_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthTimelineBloc(),
      child: BlocBuilder<HealthTimelineBloc, HealthTimelineState>(
        builder: (context, state) {
          final filteredItems = state.selectedFilter == "All"
              ? timelineItems
              : timelineItems
              .where(
                (item) => item["type"] == state.selectedFilter,
          )
              .toList();

          return Scaffold(
            backgroundColor: AppColors.scaffoldBg,
            appBar: AppBarWidget(
              title: "Health Timeline",
              showBack: true,
            ),

            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _buildFilters(context, state.selectedFilter),

                  SizedBox(height: 16.h),

                  Expanded(
                    child: filteredItems.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return _buildTimelineCard(
                          filteredItems[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilters(
      BuildContext context,
      String selectedFilter,
      ) {
    final filters = [
      "All",
      "Period",
      "Symptom",
      "Record",
      "Insight",
      "Doctor",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ChoiceChip(
              label: Text(filter),
              selected: selectedFilter == filter,
              onSelected: (_) {
                context.read<HealthTimelineBloc>().add(
                  ChangeTimelineFilterEvent(filter),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimelineCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              item["icon"],
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: AppTextStyles.bodyLarge,
                ),
                SizedBox(height: 4.h),
                Text(
                  item["date"],
                  style: AppTextStyles.bodySmall,
                ),
                SizedBox(height: 8.h),
                Text(
                  item["description"],
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            size: 60.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 12.h),
          Text(
            "No timeline entries found",
            style: AppTextStyles.heading3,
          ),
          SizedBox(height: 6.h),
          Text(
            "Your health activities will appear here",
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}