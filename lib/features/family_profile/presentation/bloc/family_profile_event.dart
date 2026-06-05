import 'package:sparkle_lite/features/family_profile/data/models/family_profile_model.dart';

abstract class FamilyProfileEvent {}

class AddFamilyMemberEvent extends FamilyProfileEvent {
  final FamilyProfileModel member;

  AddFamilyMemberEvent(this.member);
}

class DeleteFamilyMemberEvent extends FamilyProfileEvent {
  final FamilyProfileModel member;

  DeleteFamilyMemberEvent(this.member);
}