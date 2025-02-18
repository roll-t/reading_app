import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';

abstract class LoginRepository {
  Future<UserModel?> googleSignIn();
  Future<UserModel?> signin(String email, String password);
  Future<bool> emailExits(String email);
}
