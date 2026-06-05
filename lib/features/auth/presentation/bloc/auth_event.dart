import 'package:sparkle_lite/features/auth/data/models/user_data_model.dart';


abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}