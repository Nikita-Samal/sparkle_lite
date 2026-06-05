abstract class HealthTimelineEvent {}

class ChangeTimelineFilterEvent extends HealthTimelineEvent {
  final String filter;

  ChangeTimelineFilterEvent(this.filter);
}