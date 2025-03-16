import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class CheckCategoryCacheUsecase {
  final Prefs _prefs;

  CheckCategoryCacheUsecase(this._prefs);

  Future<bool> call() async {
    try {
      var checkSetUp = await _prefs.get(PrefsConstants.categoryCache);
      if (checkSetUp.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      await _prefs.set(PrefsConstants.categoryCache, "");
      return false;
    }
  }
}
