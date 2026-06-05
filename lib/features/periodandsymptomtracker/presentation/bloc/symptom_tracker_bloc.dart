import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/data/models/symptom_tracker_data_model.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_event.dart';
import 'package:sparkle_lite/features/periodandsymptomtracker/presentation/bloc/symptom_tracker_state.dart';

class SymptomTrackerBloc
    extends Bloc<SymptomTrackerEvent, SymptomTrackerState> {
  SymptomTrackerBloc() : super(SymptomTrackerState()) {
    on<AddSymptomLogEvent>(_addLog);
  }

  void _addLog(
      AddSymptomLogEvent event,
      Emitter<SymptomTrackerState> emit,
      ) {
    final newLog = SymptomTrackerDataModel(
      date: event.date,
      status: event.status,
      flow: event.flow,
    );

    emit(
      state.copyWith(
        logs: [newLog, ...state.logs],
      ),
    );
  }
}