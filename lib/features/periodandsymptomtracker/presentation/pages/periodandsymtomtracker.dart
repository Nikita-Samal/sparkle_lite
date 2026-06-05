import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_bloc.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_event.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_state.dart';

class PeriodSymptomTrackingPage extends StatefulWidget {
  const PeriodSymptomTrackingPage({super.key});

  @override
  State<PeriodSymptomTrackingPage> createState() =>
      _PeriodSymptomTrackingPageState();
}

class _PeriodSymptomTrackingPageState
    extends State<PeriodSymptomTrackingPage> {
  DateTime? selectedDate;
  String? periodStatus;
  String? flowLevel;

  final List<String> statusOptions = [
    "No period",
    "Period started",
    "Period ongoing",
    "Period ended",
  ];

  final List<String> flowOptions = [
    "Light",
    "Medium",
    "Heavy",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Symptom Tracking",
        showBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<SymptomTrackerBloc, SymptomTrackerState>(
                builder: (context, state) {
                  if (state.logs.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildLogList(state);
                },
              ),
            ),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        "No logs yet",
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildLogList(SymptomTrackerState state) {
    return ListView.builder(
      itemCount: state.logs.length,
      itemBuilder: (context, index) {
        final item = state.logs[index];

        return Card(
          color: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            title: Text(
              item.date,
              style: AppTextStyles.bodyLarge,
            ),
            subtitle: Text(
              "${item.status} • ${item.flow}",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _datePicker(),
        SizedBox(height: 12.h),

        _dropdown(
          "Period Status",
          periodStatus,
          statusOptions,
              (val) {
            setState(() {
              periodStatus = val;
            });
          },
        ),

        SizedBox(height: 12.h),

        _dropdown(
          "Flow Level",
          flowLevel,
          flowOptions,
              (val) {
            setState(() {
              flowLevel = val;
            });
          },
        ),

        SizedBox(height: 20.h),

        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: _submit,
            child: Text(
              "Save Log",
              style: AppTextStyles.buttonText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _datePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.cardBg,
        ),
        child: Text(
          selectedDate == null
              ? "Select Date"
              : selectedDate.toString().split(" ")[0],
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }

  Widget _dropdown(
      String hint,
      String? value,
      List<String> items,
      Function(String?) onChanged,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.cardBg,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        hint: Text(
          hint,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        underline: const SizedBox(),
        items: items
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _submit() {
    if (selectedDate == null ||
        periodStatus == null ||
        flowLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    BlocProvider.of<SymptomTrackerBloc>(context).add(
      AddSymptomLogEvent(
        date: selectedDate.toString().split(" ")[0],
        status: periodStatus!,
        flow: flowLevel!,
      ),
    );

    setState(() {
      selectedDate = null;
      periodStatus = null;
      flowLevel = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Log saved successfully"),
      ),
    );
  }
}