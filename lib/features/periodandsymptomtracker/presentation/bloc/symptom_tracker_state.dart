import 'package:sparkle_lite/features/periodandsymptomtracker/data/models/symptom_tracker_data_model.dart';

class SymptomTrackerState {
  final List<SymptomTrackerDataModel> logs;
  final bool isLoading;
  final String error;

  SymptomTrackerState({
    this.logs = const [],
    this.isLoading = false,
    this.error = '',
  });

  SymptomTrackerState copyWith({
    List<SymptomTrackerDataModel>? logs,
    bool? isLoading,
    String? error,
  }) {
    return SymptomTrackerState(
      logs: logs ?? this.logs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}