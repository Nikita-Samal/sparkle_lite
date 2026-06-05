import 'package:sparkle_lite/features/health_profile/data/models/health_profile_model.dart';


class HealthProfileState {
  final String name;
  final String age;
  final String lifeStage;

  HealthProfileState({
    this.name = "Niki",
    this.age = "28",
    this.lifeStage = "General Wellness",
  });

  HealthProfileState copyWith({
    String? name,
    String? age,
    String? lifeStage,
  }) {
    return HealthProfileState(
      name: name ?? this.name,
      age: age ?? this.age,
      lifeStage: lifeStage ?? this.lifeStage,
    );
  }
}