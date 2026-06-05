import 'package:flutter/material.dart';
import 'package:sparkle_lite/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/pages/periodandsymtomtracker.dart';
import 'package:sparkle_lite/features/health_records/presentation/pages/health_records_page.dart';
import 'package:sparkle_lite/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_bloc.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_bloc.dart';
import 'package:sparkle_lite/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sparkle_lite/core/colors/app_colors.dart';

class NavigationBarWidget extends StatefulWidget {
  NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      DashboardPage(),

      BlocProvider(
        create: (_) => SymptomTrackerBloc(),
        child:  PeriodSymptomTrackingPage(),
      ),

      BlocProvider(
        create: (_) => HealthRecordBloc(),
        child:  HealthRecordsPage(),
      ),

      BlocProvider(
        create: (_) => ProfileBloc(),
        child:  ProfilePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.white,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: "Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Records",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}