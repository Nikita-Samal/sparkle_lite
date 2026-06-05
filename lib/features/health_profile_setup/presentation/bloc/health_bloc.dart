import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/health_profile_setup/data/models/health_profile_setup_data_model.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  HealthBloc() : super(const HealthState()) {
    on<NextStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step + 1));
    });

    on<PrevStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step - 1));
    });

    on<UpdateDataEvent>((event, emit) {
      emit(state.copyWith(data: event.data));
    });
  }
}