import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class GetAuthTokenUseCase {
  static final Prefs prefs = Prefs();
  Future<String?> call() async {
    try {
      final String tokenJson = await prefs.get(PrefsConstants.authentication);
      final String authenticationModel = tokenJson;
      return authenticationModel;
    } catch (e) {
      return "";
    }
  }
}
