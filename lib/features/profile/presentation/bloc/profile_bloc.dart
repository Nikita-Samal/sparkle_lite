import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/profile/presentation/bloc/profile_event.dart';
import 'package:sparkle_lite/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<LogoutEvent>((event, emit) {});
  }
}