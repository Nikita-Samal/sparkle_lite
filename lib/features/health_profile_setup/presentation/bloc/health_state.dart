import 'package:sparkle_lite/features/health_profile_setup/data/models/health_profile_setup_data_model.dart';

class HealthState {
  final int step;
  final HealthProfileSetupDataModel data;

  const HealthState({
    this.step = 0,
    this.data = const HealthProfileSetupDataModel(),
  });

  HealthState copyWith({
    int? step,
    HealthProfileSetupDataModel? data,
  }) {
    return HealthState(
      step: step ?? this.step,
      data: data ?? this.data,
    );
  }
}