import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/family_profile/data/models/family_profile_model.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_event.dart';
import 'package:sparkle_lite/features/family_profile/presentation/bloc/family_profile_state.dart';

class FamilyProfileBloc
    extends Bloc<FamilyProfileEvent, FamilyProfileState> {
  FamilyProfileBloc() : super(FamilyProfileState()) {
    on<AddFamilyMemberEvent>(_addMember);
    on<DeleteFamilyMemberEvent>(_deleteMember);
  }

  void _addMember(
      AddFamilyMemberEvent event,
      Emitter<FamilyProfileState> emit,
      ) {
    emit(
      state.copyWith(
        familyMembers: [
          ...state.familyMembers,
          event.member,
        ],
      ),
    );
  }

  void _deleteMember(
      DeleteFamilyMemberEvent event,
      Emitter<FamilyProfileState> emit,
      ) {
    final updatedMembers =
    List<FamilyProfileModel>.from(state.familyMembers)
      ..remove(event.member);

    emit(
      state.copyWith(
        familyMembers: updatedMembers,
      ),
    );
  }
}