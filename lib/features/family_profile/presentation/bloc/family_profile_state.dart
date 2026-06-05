import 'package:sparkle_lite/features/family_profile/data/models/family_profile_model.dart';

class FamilyProfileState {
  final List<FamilyProfileModel> familyMembers;

  FamilyProfileState({
    this.familyMembers = const [],
  });

  FamilyProfileState copyWith({
    List<FamilyProfileModel>? familyMembers,
  }) {
    return FamilyProfileState(
      familyMembers: familyMembers ?? this.familyMembers,
    );
  }
}