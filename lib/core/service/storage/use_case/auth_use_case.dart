import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/service/storage/prefs/prefs.dart';
import 'package:reading_app/core/service/storage/use_case/get_user_use_case.dart';

class AuthUseCase {
  static final Prefs prefs = Prefs();
  static final GetuserUseCase getuserUseCase = GetuserUseCase(prefs);
  static Future<String> getAuthToken() async {
    try {
      final String tokenJson = await prefs.get(PrefsConstants.authentication);
      final String authenticationModel = tokenJson;
      return authenticationModel;
    } catch (e) {
      return "";
    }
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
