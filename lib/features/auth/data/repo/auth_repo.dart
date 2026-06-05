import 'package:sparkle_lite/features/auth/data/models/user_data_model.dart';

abstract class AuthRepo {
  Future<UserDataModel> login(String email, String password);
  Future<UserDataModel> signup(String email, String password);
  Future<void> logout();
}