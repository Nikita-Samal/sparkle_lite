import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_bloc.dart';
import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_event.dart';
import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_state.dart';

class HealthProfilePage extends StatefulWidget {
  const HealthProfilePage({super.key});

  @override
  State<HealthProfilePage> createState() => _HealthProfilePageState();
}

class _HealthProfilePageState extends State<HealthProfilePage> {
  final TextEditingController nameController =
  TextEditingController(text: "Niki");

  final TextEditingController ageController =
  TextEditingController(text: "28");

  final List<String> lifeStages = [
    "General Wellness",
    "Period Tracking",
    "Fertility Planning",
    "Pregnancy",
    "Postpartum",
    "Menopause",
  ];

  void saveProfile() {
    final bloc = context.read<HealthProfileBloc>();

    bloc.add(
      SaveHealthProfileEvent(
        name: nameController.text,
        age: ageController.text,
        lifeStage: bloc.state.lifeStage,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Health profile saved"),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthProfileBloc, HealthProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: AppBar(
            title: Text(
              "Health Profile",
              style: AppTextStyles.heading3,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _inputField("Name", nameController),

                SizedBox(height: 12.h),

                _inputField("Age", ageController),

                SizedBox(height: 12.h),

                _dropdown(state),

                SizedBox(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: saveProfile,
                    child: Text(
                      "Save Profile",
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputField(
      String hint,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _dropdown(HealthProfileState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButton<String>(
        value: state.lifeStage,
        isExpanded: true,
        underline: const SizedBox(),
        items: lifeStages.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (val) {
          context.read<HealthProfileBloc>().add(
            ChangeLifeStageEvent(val!),
          );
        },
      ),
    );
  }
}