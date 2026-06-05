import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkle_lite/features/health_timeline/presentation/bloc/timeline_event.dart';
import 'package:sparkle_lite/features/health_timeline/presentation/bloc/timeline_state.dart';



class HealthTimelineBloc
    extends Bloc<HealthTimelineEvent, HealthTimelineState> {
  HealthTimelineBloc() : super(const HealthTimelineState()) {
    on<ChangeTimelineFilterEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedFilter: event.filter,
        ),
      );
    });
  }
}