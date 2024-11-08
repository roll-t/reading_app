
import 'package:reading_app/core/data/database/model/authentication_model.dart';
import 'package:reading_app/core/data/domain/user/get_user_use_case.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';

class AuthUseCase {
  static final Prefs prefs = Prefs();
  static final GetuserUseCase getuserUseCase = GetuserUseCase(prefs);

  // Method to retrieve the authentication token
  static Future<String> getAuthToken() async {
    try {
      final AuthenticationModel? authenticationModel =
          await getuserUseCase.getToken();
      if (authenticationModel != null) {
        return authenticationModel.token;
      }
    } catch (e) {
      return "";
    }
    return "";
  }

  // Method to check if user is logged in
  static Future<bool> isLogin() async {
    try {
      final token = await getAuthToken();
      return token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
