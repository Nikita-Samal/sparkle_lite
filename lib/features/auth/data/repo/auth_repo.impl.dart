import 'package:sparkle_lite/features/auth/data/models/user_data_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<UserDataModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "samal@gmail" && password == "123456") {
      return UserDataModel(email: email);
    }

    throw Exception("Invalid login credentials");
  }

  @override
  Future<UserDataModel> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.length >= 6) {
      return UserDataModel(email: email);
    }

    throw Exception("Invalid signup data");
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}