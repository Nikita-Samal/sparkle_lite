import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sparkle_lite/features/auth/data/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;

  AuthBloc(this.repo) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<SignupEvent>(_signup);
    on<LogoutEvent>(_logout);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await repo.login(event.email.trim(), event.password.trim());
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await repo.signup(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (_) {
      emit(AuthFailure("Signup failed"));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await repo.logout();
    emit(AuthUnauthenticated());
  }
}