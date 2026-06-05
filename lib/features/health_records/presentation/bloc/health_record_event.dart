import 'package:sparkle_lite/features/health_records/data/models/health_record_model.dart';

abstract class HealthRecordEvent {}

class AddHealthRecordEvent extends HealthRecordEvent {
  final HealthRecordModel record;

  AddHealthRecordEvent(this.record);
}

class DeleteHealthRecordEvent extends HealthRecordEvent {
  final HealthRecordModel record;

  DeleteHealthRecordEvent(this.record);
}