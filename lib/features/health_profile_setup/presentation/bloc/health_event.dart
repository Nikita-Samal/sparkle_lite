import 'package:sparkle_lite/features/health_profile_setup/data/models/health_profile_setup_data_model.dart';


abstract class HealthEvent {}

class NextStepEvent extends HealthEvent {}

class PrevStepEvent extends HealthEvent {}

class UpdateDataEvent extends HealthEvent {
  final HealthProfileSetupDataModel data;

  UpdateDataEvent(this.data);
}