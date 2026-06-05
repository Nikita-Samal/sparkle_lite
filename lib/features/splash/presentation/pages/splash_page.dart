import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/features/auth/presentation/pages/auth_page.dart';
import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> splashData = [
    {
      "image": "assets/images/splash_1.png",
      "title": "Healthcare",
      "subtitle": "Monitor your health easily."
    },
    {
      "image": "assets/images/splash_2.png",
      "title": "Track",
      "subtitle": "Manage symptoms & reports."
    },
    {
      "image": "assets/images/splash_3.png",
      "title": "Connect",
      "subtitle": "Prepare for doctor visits."
    },
  ];

  void goToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWeb = constraints.maxWidth > 600;

          Widget page = Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: splashData.length,
                onPageChanged: (i) => setState(() => currentIndex = i),
                itemBuilder: (_, i) {
                  final item = splashData[i];

                  return Container(
                    color: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item["image"]!, height: 300.h),
                          SizedBox(height: 40.h),
                          Text(
                            item["title"]!,
                            style: AppTextStyles.heading1
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            item["subtitle"]!,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 120.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                        (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: currentIndex == i ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.white
                            : Colors.white38,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
              ),

              if (currentIndex == splashData.length - 1)
                Positioned(
                  bottom: 40.h,
                  right: 24.w,
                  child: GestureDetector(
                    onTap: goToAuth,
                    child: Container(
                      height: 60.r,
                      width: 60.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_forward,
                          color: AppColors.primary),
                    ),
                  ),
                ),
            ],
          );

          if (!isWeb) return page;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: page,
            ),
          );
        },
      ),
    );
  }
}