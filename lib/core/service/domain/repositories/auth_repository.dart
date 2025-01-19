import 'package:reading_app/core/service/data/model/authentication_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';

abstract class AuthRepository {
  Future<String?> getAuthToken();
  Future<void> setAuthToken(String token);
  Future<bool> isLogin();
  Future<bool> isTokenValid(String token);
  Future<Result<AuthenticationModel>?> authenticate(
      String email, String password);
}
