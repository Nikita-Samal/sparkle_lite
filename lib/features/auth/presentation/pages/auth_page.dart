import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/common/NavBar/navigationbarwidget.dart';
import 'package:sparkle_lite/features/auth/presentation/bloc/auth_state.dart';
import 'package:sparkle_lite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sparkle_lite/features/auth/presentation/bloc/auth_event.dart';
import 'package:sparkle_lite/features/auth/data/repo/auth_repo.impl.dart';

import 'package:sparkle_lite/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sparkle_lite/features/health_profile_setup/presentation/pages/health_profile_setup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}• Key technical decisions
• Architecture
• State management
• Data persistence
• Privacy considerations
• Trade offs
• What you would do next in production

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepoImpl()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => NavigationBarWidget()),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  SizedBox(height: 30.h),
                  _toggle(),
                  SizedBox(height: 30.h),
                  isLogin ? _loginForm() : _signupForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.favorite,
            size: 80.sp,
            color: AppColors.primary,
          ),
          SizedBox(height: 10.h),
          Text(
            "Sparkle Lite",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tab("Login", isLogin, () => setState(() => isLogin = true)),
        SizedBox(width: 30.w),
        _tab("Sign Up", !isLogin, () => setState(() => isLogin = false)),
      ],
    );
  }

  Widget _tab(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: active ? 18.sp : 14.sp,
              fontWeight: FontWeight.bold,
              color: active
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          if (active)
            Container(
              height: 2,
              width: 40,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
            validator: (v) => v!.isEmpty ? "Required" : null,
          ),

          SizedBox(height: 16.h),

          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
            obscureText: true,
            validator: (v) => v!.length < 6 ? "Min 6 chars" : null,
          ),

          SizedBox(height: 24.h),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final loading = state is AuthLoading;

              return SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: loading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                      );
                    }
                  },
                  child: loading
                      ?  CircularProgressIndicator(
                    color: AppColors.white,
                  )
                      : Text(
                    "Continue",
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _signupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(height: 20.h),

        TextField(
          decoration: InputDecoration(
            hintText: "Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.border),
            ),
          ),
        ),

        SizedBox(height: 24.h),

        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HealthProfileSetupPage(),
                ),
              );
            },
            child: Text(
              "Continue",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}