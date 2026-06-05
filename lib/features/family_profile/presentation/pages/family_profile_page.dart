import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

import 'package:sparkle_lite/features/family_profile/data/models/family_profile_model.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_bloc.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_event.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_state.dart';

class FamilyProfilePage extends StatefulWidget {
  const FamilyProfilePage({super.key});

  @override
  State<FamilyProfilePage> createState() => _FamilyProfilePageState();
}

class _FamilyProfilePageState extends State<FamilyProfilePage> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController notesController =
  TextEditingController();

  String? selectedRelationship;
  String? selectedAgeRange;

  final List<String> relationships = [
    "Mother",
    "Father",
    "Spouse",
    "Child",
    "Sibling",
    "Other",
  ];

  final List<String> ageRanges = [
    "0 - 10",
    "11 - 20",
    "21 - 40",
    "41 - 60",
    "60+",
  ];

  @override
  void dispose() {
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void addFamilyMember() {
    if (nameController.text.trim().isEmpty ||
        selectedRelationship == null ||
        selectedAgeRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all required fields",
          ),
        ),
      );
      return;
    }

    context.read<FamilyProfileBloc>().add(
      AddFamilyMemberEvent(
        FamilyProfileModel(
          name: nameController.text.trim(),
          relationship: selectedRelationship!,
          ageRange: selectedAgeRange!,
          notes: notesController.text.trim(),
        ),
      ),
    );

    setState(() {
      nameController.clear();
      notesController.clear();
      selectedRelationship = null;
      selectedAgeRange = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        FamilyProfileBloc,
        FamilyProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: AppBar(
            title: Text(
              "Family Profiles",
              style: AppTextStyles.heading3,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius:
                    BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Family records are stored separately from your personal health information.",
                    style: AppTextStyles.bodyMedium,
                  ),
                ),

                SizedBox(height: 16.h),

                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius:
                    BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name / Nickname",
                        ),
                      ),

                      SizedBox(height: 12.h),

                      DropdownButtonFormField<String>(
                        value: selectedRelationship,
                        decoration: const InputDecoration(
                          labelText: "Relationship",
                        ),
                        items: relationships
                            .map(
                              (item) =>
                              DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRelationship =
                                value;
                          });
                        },
                      ),

                      SizedBox(height: 12.h),

                      DropdownButtonFormField<String>(
                        value: selectedAgeRange,
                        decoration: const InputDecoration(
                          labelText: "Age Range",
                        ),
                        items: ageRanges
                            .map(
                              (item) =>
                              DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAgeRange = value;
                          });
                        },
                      ),

                      SizedBox(height: 12.h),

                      TextField(
                        controller: notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Basic Notes",
                        ),
                      ),

                      SizedBox(height: 16.h),

                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: addFamilyMember,
                          child: Text(
                            "Add Family Member",
                            style:
                            AppTextStyles.buttonText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Family Members",
                    style: AppTextStyles.heading3,
                  ),
                ),

                SizedBox(height: 12.h),

                Expanded(
                  child: state.familyMembers.isEmpty
                      ? Center(
                    child: Text(
                      "No family members added",
                      style: AppTextStyles
                          .bodyMedium,
                    ),
                  )
                      : ListView.builder(
                    itemCount: state
                        .familyMembers.length,
                    itemBuilder:
                        (context, index) {
                      final member = state
                          .familyMembers[index];

                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 12.h),
                        decoration: BoxDecoration(
                          color:
                          AppColors.cardBg,
                          borderRadius:
                          BorderRadius
                              .circular(
                              12.r),
                          border: Border.all(
                            color: AppColors
                                .border,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            member.name,
                            style: AppTextStyles
                                .bodyLarge,
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              SizedBox(
                                  height: 4.h),
                              Text(
                                "${member.relationship} • ${member.ageRange}",
                                style:
                                AppTextStyles
                                    .bodyMedium,
                              ),
                              if (member.notes
                                  .isNotEmpty)
                                Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                    top: 4.h,
                                  ),
                                  child: Text(
                                    member.notes,
                                    style:
                                    AppTextStyles
                                        .bodySmall,
                                  ),
                                ),
                            ],
                          ),
                          trailing:
                          IconButton(
                            icon: Icon(
                              Icons
                                  .delete_outline,
                              color: AppColors
                                  .error,
                            ),
                            onPressed: () {
                              context
                                  .read<
                                  FamilyProfileBloc>()
                                  .add(
                                DeleteFamilyMemberEvent(
                                  member,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}