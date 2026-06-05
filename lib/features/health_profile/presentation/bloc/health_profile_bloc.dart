import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_event.dart';
import 'package:sparkle_lite/features/health_profile/presentation/bloc/health_profile_state.dart';

class HealthProfileBloc
    extends Bloc<HealthProfileEvent, HealthProfileState> {
  HealthProfileBloc() : super(HealthProfileState()) {
    on<ChangeLifeStageEvent>((event, emit) {
      emit(
        state.copyWith(
          lifeStage: event.lifeStage,
        ),
      );
    });

    on<SaveHealthProfileEvent>((event, emit) {
      emit(
        state.copyWith(
          name: event.name,
          age: event.age,
          lifeStage: event.lifeStage,
        ),
      );
    });
  }
}