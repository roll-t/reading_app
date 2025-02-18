import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class SaveUserUseCase {
  final Prefs _prefs;

  SaveUserUseCase(this._prefs);

  Future<void> saveUser(UserModel? user) async {
    if (user != null) {
      try {
        final userJson = jsonEncode(user.toJson());
        await _prefs.set(PrefsConstants.user, userJson);
      } catch (e) {
        // Handle the error, maybe log it or show an alert
        print('Failed to save user: $e');
      }
    }
  }

  Future<void> saveToken(AuthenticationModel model) async {
    try {
      final authentication = jsonEncode(model.toJson());
      await _prefs.set(PrefsConstants.authentication, authentication);
    } catch (e) {
      // Handle the error, maybe log it or show an alert
      print('Failed to save user: $e');
    }
    }
}
