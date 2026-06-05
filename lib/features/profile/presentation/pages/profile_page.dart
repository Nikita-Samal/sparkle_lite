import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';
import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

import 'package:sparkle_lite/features/family_profile/presentation/pages/family_profile_page.dart';
import 'package:sparkle_lite/features/settings/presentation/pages/privacy_settings_page.dart';
import 'package:sparkle_lite/features/settings/presentation/pages/notification_preferences_page.dart';
import 'package:sparkle_lite/features/health_profile/presentation/pages/health_profile_page.dart';

import 'package:sparkle_lite/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sparkle_lite/features/profile/presentation/bloc/profile_event.dart';
import 'package:sparkle_lite/features/profile/presentation/bloc/profile_state.dart';
import 'package:sparkle_lite/features/auth/presentation/pages/auth_page.dart';
import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_bloc.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_bloc.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    context.read<ProfileBloc>().add(
      LogoutEvent(),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>  AuthPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: AppBarWidget(
            title: "Profile page",
            showBack: false,
          ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _buildHeader(),

                  SizedBox(height: 24.h),

                  _buildMenuTile(
                    icon: Icons.person_outline,
                    title: "Health Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => HealthProfileBloc(),
                            child:  HealthProfilePage(),
                          ),
                        ),
                      );
                    },
                  ),

                  _buildMenuTile(
                    icon: Icons.people_outline,
                    title: "Family Profiles",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => FamilyProfileBloc(),
                            child: FamilyProfilePage(),
                          ),
                        ),
                      );
                    },
                  ),

                  _buildMenuTile(
                    icon: Icons.lock_outline,
                    title: "Privacy Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PrivacySettingsPage(),
                        ),
                      );
                    },
                  ),

                  _buildMenuTile(
                    icon: Icons.notifications_outlined,
                    title: "Notification Preferences",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NotificationPreferencesPage(),
                        ),
                      );
                    },
                  ),

                  _buildMenuTile(
                    icon: Icons.info_outline,
                    title: "About App",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("About App"),
                            content: const Text(
                              "Health tracking app for symptoms, records, timeline and insights.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text("Close"),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () => _logout(context),
                      child: Text(
                        "Logout",
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person,
              size: 35.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Niki",
            style: AppTextStyles.heading3,
          ),
          SizedBox(height: 4.h),
          Text(
            "General Wellness",
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppColors.cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: AppColors.border,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}