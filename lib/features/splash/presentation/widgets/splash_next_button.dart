import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashNextButton extends StatelessWidget {
  final VoidCallback onTap;

  const SplashNextButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.r,
        width: 60.r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          Icons.arrow_forward,
          size: 24.sp,
          color: const Color(0xFF2D8B78),
        ),
      ),
    );
  }
}