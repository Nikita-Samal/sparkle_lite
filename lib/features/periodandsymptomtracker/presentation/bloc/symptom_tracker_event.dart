abstract class SymptomTrackerEvent {}

class AddSymptomLogEvent extends SymptomTrackerEvent {
  final String date;
  final String status;
  final String flow;

  AddSymptomLogEvent({
    required this.date,
    required this.status,
    required this.flow,
  });
}