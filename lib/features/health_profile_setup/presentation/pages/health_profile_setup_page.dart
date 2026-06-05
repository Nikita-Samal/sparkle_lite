import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/features/health_profile_setup/presentation/bloc/health_bloc.dart';
import 'package:sparkle_lite/features/health_profile_setup/presentation/bloc/health_event.dart';
import 'package:sparkle_lite/features/health_profile_setup/presentation/bloc/health_state.dart';

import 'package:sparkle_lite/features/health_profile_setup/data/models/health_profile_setup_data_model.dart';

import 'package:sparkle_lite/common/NavBar/navigationbarwidget.dart';
import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class HealthProfileSetupPage extends StatelessWidget {
  const HealthProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthBloc(),
      child: BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    Text(
                      "Health Profile Setup",
                      style: AppTextStyles.heading2,
                    ),

                    SizedBox(height: 20.h),

                    Expanded(child: _buildStep(context, state)),

                    _buildButton(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(BuildContext context, HealthState state) {
    switch (state.step) {
      case 0:
        return _basicInfo(context, state);
      case 1:
        return _lifeStage(context, state);
      case 2:
        return _conditions(context, state);
      case 3:
        return _preferences(context, state);
      default:
        return SizedBox();
    }
  }

  Widget _basicInfo(BuildContext context, HealthState state) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Name"),
          onChanged: (val) {
            final updated = state.data.copyWith(name: val);
            context.read<HealthBloc>().add(UpdateDataEvent(updated));
          },
        ),

        SizedBox(height: 16.h),

        TextField(
          decoration: InputDecoration(hintText: "Age"),
          onChanged: (val) {
            final updated = state.data.copyWith(age: val);
            context.read<HealthBloc>().add(UpdateDataEvent(updated));
          },
        ),
      ],
    );
  }

  Widget _lifeStage(BuildContext context, HealthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Life Stage", style: AppTextStyles.bodyLarge),
        SizedBox(height: 12.h),

        _option(context, "General Wellness", state),
        _option(context, "Period Tracking", state),
        _option(context, "Fertility Planning", state),
        _option(context, "Pregnancy", state),
        _option(context, "Postpartum", state),
        _option(context, "Menopause / Perimenopause", state),
      ],
    );
  }

  Widget _option(BuildContext context, String text, HealthState state) {
    return RadioListTile(
      value: text,
      groupValue: state.data.lifeStage,
      onChanged: (val) {
        final updated = state.data.copyWith(lifeStage: val.toString());
        context.read<HealthBloc>().add(UpdateDataEvent(updated));
      },
      title: Text(text),
    );
  }

  Widget _conditions(BuildContext context, HealthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Known Conditions (Optional)", style: AppTextStyles.bodyLarge),

        CheckboxListTile(
          value: state.data.pcod,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(pcod: v!)),
            );
          },
          title: Text("PCOS"),
        ),

        CheckboxListTile(
          value: state.data.thyroid,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(thyroid: v!)),
            );
          },
          title: Text("Thyroid"),
        ),

        CheckboxListTile(
          value: state.data.diabetes,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(diabetes: v!)),
            );
          },
          title: Text("Diabetes"),
        ),

        CheckboxListTile(
          value: state.data.endometriosis,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(endometriosis: v!)),
            );
          },
          title: Text("Endometriosis"),
        ),

        TextField(
          decoration: InputDecoration(hintText: "Other (optional)"),
        ),
      ],
    );
  }

  Widget _preferences(BuildContext context, HealthState state) {
    return Column(
      children: [
        CheckboxListTile(
          value: state.data.privacy,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(privacy: v!)),
            );
          },
          title: Text("Privacy preference"),
        ),

        CheckboxListTile(
          value: state.data.notifications,
          onChanged: (v) {
            context.read<HealthBloc>().add(
              UpdateDataEvent(state.data.copyWith(notifications: v!)),
            );
          },
          title: Text("Notification preference"),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, HealthState state) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        onPressed: () {
          if (state.step < 3) {
            context.read<HealthBloc>().add(NextStepEvent());
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => NavigationBarWidget()
              ),
            );
          }
        },
        child: Text(
          state.step == 3 ? "Finish" : "Continue",
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}