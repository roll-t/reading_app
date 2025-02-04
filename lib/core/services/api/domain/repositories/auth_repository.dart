import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';

abstract class AuthRepository {
  Future<String?> getAuthToken();
  Future<void> setAuthToken(String token);
  Future<bool> isLogin();
  Future<bool> isTokenValid(String token);
  Future<Result<AuthenticationModel>?> authenticate(
      String email, String password);
}
