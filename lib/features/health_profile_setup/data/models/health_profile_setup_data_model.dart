class HealthProfileSetupDataModel {
  final String name;
  final String age;
  final String? lifeStage;

  final bool pcod;
  final bool thyroid;
  final bool diabetes;
  final bool endometriosis;

  final bool privacy;
  final bool notifications;

  const HealthProfileSetupDataModel({
    this.name = '',
    this.age = '',
    this.lifeStage,
    this.pcod = false,
    this.thyroid = false,
    this.diabetes = false,
    this.endometriosis = false,
    this.privacy = false,
    this.notifications = false,
  });

  HealthProfileSetupDataModel copyWith({
    String? name,
    String? age,
    String? lifeStage,
    bool? pcod,
    bool? thyroid,
    bool? diabetes,
    bool? endometriosis,
    bool? privacy,
    bool? notifications,
  }) {
    return HealthProfileSetupDataModel(
      name: name ?? this.name,
      age: age ?? this.age,
      lifeStage: lifeStage ?? this.lifeStage,
      pcod: pcod ?? this.pcod,
      thyroid: thyroid ?? this.thyroid,
      diabetes: diabetes ?? this.diabetes,
      endometriosis: endometriosis ?? this.endometriosis,
      privacy: privacy ?? this.privacy,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "lifeStage": lifeStage,
      "pcod": pcod,
      "thyroid": thyroid,
      "diabetes": diabetes,
      "endometriosis": endometriosis,
      "privacy": privacy,
      "notifications": notifications,
    };
  }
}