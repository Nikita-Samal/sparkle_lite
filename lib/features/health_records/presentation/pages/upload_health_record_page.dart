import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/core/colors/app_colors.dart';
import 'package:sparkle_lite/core/theme/app_textstyles.dart';

class UploadHealthRecordPage extends StatefulWidget {
  UploadHealthRecordPage({super.key});

  @override
  State<UploadHealthRecordPage> createState() =>
      _UploadHealthRecordPageState();
}

class _UploadHealthRecordPageState
    extends State<UploadHealthRecordPage> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController doctorController =
  TextEditingController();

  final TextEditingController notesController =
  TextEditingController();

  String? selectedType;
  DateTime? selectedDate;

  final List<String> types = [
    "Lab Report",
    "Prescription",
    "Scan Report",
    "Doctor Visit Note",
    "Vaccination Record",
    "Other"
  ];

  @override
  void dispose() {
    titleController.dispose();
    doctorController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void uploadRecord() {
    if (titleController.text.isEmpty || selectedType == null || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title, Type and Date are required"),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      "title": titleController.text,
      "type": selectedType,
      "date": selectedDate.toString().split(" ")[0],
      "doctor": doctorController.text,
      "notes": notesController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          "Upload Health Record",
          style: AppTextStyles.heading3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Report Title",
              ),
            ),

            SizedBox(height: 12.h),

            DropdownButtonFormField(
              value: selectedType,
              items: types
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedType = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "Report Type",
              ),
            ),

            SizedBox(height: 12.h),

            InkWell(
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
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : selectedDate.toString().split(" ")[0],
                ),
              ),
            ),

            SizedBox(height: 12.h),

            TextField(
              controller: doctorController,
              decoration: const InputDecoration(
                labelText: "Doctor / Clinic (Optional)",
              ),
            ),

            SizedBox(height: 12.h),

            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Notes (Optional)",
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                onPressed: uploadRecord,
                child: Text(
                  "Upload Record",
                  style: AppTextStyles.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}