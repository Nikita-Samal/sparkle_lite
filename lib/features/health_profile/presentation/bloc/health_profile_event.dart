

abstract class HealthProfileEvent {}

class SaveHealthProfileEvent extends HealthProfileEvent {
  final String name;
  final String age;
  final String lifeStage;

  SaveHealthProfileEvent({
    required this.name,
    required this.age,
    required this.lifeStage,
  });
}

class ChangeLifeStageEvent extends HealthProfileEvent {
  final String lifeStage;

  ChangeLifeStageEvent(this.lifeStage);
}