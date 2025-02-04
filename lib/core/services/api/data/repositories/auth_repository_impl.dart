import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/introspect_request.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/auth_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/auth_repository.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Prefs _prefs;
  final AuthService _authService;
  AuthRepositoryImpl(this._prefs, this._authService);

  @override
  Future<String?> getAuthToken() async {
    try {
      final String token = await _prefs.get(PrefsConstants.authentication);
      if (token.isEmpty) {
        return null;
      }
      return token;
    } catch (e) {
      print('Error fetching auth token: $e');
      return null;
    }
  }

  @override
  Future<void> setAuthToken(String token) async {
    try {
      await _prefs.set(PrefsConstants.authentication, token);
    } catch (e) {
      print('Error saving auth token: $e');
    }
  }

  @override
  Future<bool> isLogin() async {
    try {
      final String? token = await getAuthToken();
      if (token == null) {
        return false;
      }
      return await isTokenValid(token);
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  @override
  Future<bool> isTokenValid(String token) async {
    try {
      final Result result = await _authService.introspect(
        request: IntrospectRequest(token: token),
      );
      if (result.status == Status.success) {
        return result.data?.valid ?? false;
      }
      return false;
    } catch (e) {
      print('Error validating token: $e');
      return false;
    }
  }

  @override
  Future<Result<AuthenticationModel>?> authenticate(
      String email, String password) async {
    try {
      final Result<AuthenticationModel>? result = await _authService.token(
        userModel: UserModel(email: email.trim(), password: password.trim()),
      );
      if (result == null || result.status != Status.success) {
        return Result.error(ApiError.badRequest);
      }
      return result;
    } catch (e) {
      print('Error during authentication: $e');
      return Result.error(ApiError.badRequest);
    }
  }
}
