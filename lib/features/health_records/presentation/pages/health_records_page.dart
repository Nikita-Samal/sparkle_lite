import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sparkle_lite/features/health_records/data/models/health_record_model.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_bloc.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_event.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_state.dart';
import 'health_record_detail_page.dart';
import 'upload_health_record_page.dart';
import 'package:sparkle_lite/common/AppBar/appbarwidget.dart';

class HealthRecordsPage extends StatefulWidget {
  const HealthRecordsPage({super.key});

  @override
  State<HealthRecordsPage> createState() => _HealthRecordsPageState();
}

class _HealthRecordsPageState extends State<HealthRecordsPage> {
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthRecordBloc, HealthRecordState>(
      builder: (context, state) {
        final filteredRecords = selectedFilter == "All"
            ? state.records
            : state.records
            .where((e) => e.type == selectedFilter)
            .toList();

        return Scaffold(
          appBar: AppBarWidget(
            title: "Health Record ",
            showBack: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadHealthRecordPage(),
                ),
              );

              if (result != null) {
                context.read<HealthRecordBloc>().add(
                  AddHealthRecordEvent(
                    HealthRecordModel(
                      title: result["title"],
                      type: result["type"],
                      date: result["date"],
                      doctor: result["doctor"] ?? "",
                      notes: result["notes"] ?? "",
                    ),
                  ),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                _buildFilter(),

                SizedBox(height: 16.h),

                Expanded(
                  child: filteredRecords.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                    itemCount: filteredRecords.length,
                    itemBuilder: (context, index) {
                      return _buildRecordCard(
                        filteredRecords[index],
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

  Widget _buildFilter() {
    final filters = [
      "All",
      "Lab Report",
      "Prescription",
      "Scan Report",
      "Doctor Visit Note",
      "Vaccination Record",
      "Other",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(item),
              selected: selectedFilter == item,
              onSelected: (_) {
                setState(() {
                  selectedFilter = item;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecordCard(
      HealthRecordModel record,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(record.title),
        subtitle: Text(
          "${record.type}\n${record.date}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: "delete",
              child: Text("Delete"),
            ),
          ],
          onSelected: (value) {
            if (value == "delete") {
              context.read<HealthRecordBloc>().add(
                DeleteHealthRecordEvent(record),
              );
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HealthRecordDetailPage(
                record: {
                  "title": record.title,
                  "type": record.type,
                  "date": record.date,
                  "doctor": record.doctor,
                  "notes": record.notes,
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No health records uploaded yet",
      ),
    );
  }
}