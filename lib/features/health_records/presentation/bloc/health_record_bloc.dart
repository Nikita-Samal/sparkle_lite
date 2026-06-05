import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/health_records/data/models/health_record_model.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_event.dart';
import 'package:sparkle_lite/features/health_records/presentation/bloc/health_record_state.dart';

class HealthRecordBloc
    extends Bloc<HealthRecordEvent, HealthRecordState> {
  HealthRecordBloc()
      : super(
    HealthRecordState([
      HealthRecordModel(
        title: "Blood Test Report",
        type: "Lab Report",
        date: "12 Jul 2026",
        doctor: "Apollo Clinic",
        notes: "",
      ),
      HealthRecordModel(
        title: "Prescription July",
        type: "Prescription",
        date: "10 Jul 2026",
        doctor: "Dr. Priya",
        notes: "",
      ),
    ]),
  ) {
    on<AddHealthRecordEvent>((event, emit) {
      emit(
        HealthRecordState(
          [...state.records, event.record],
        ),
      );
    });

    on<DeleteHealthRecordEvent>((event, emit) {
      final updated = List<HealthRecordModel>.from(state.records)
        ..remove(event.record);

      emit(
        HealthRecordState(updated),
      );
    });
  }
}