import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/service/data/model/authentication_model.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';


class GetuserUseCase {
  final Prefs _prefs;

  GetuserUseCase(this._prefs);

  Future<UserModel?> getUser() async {
    try {
      // Retrieve JSON string from Prefs
      final String tokenJson = await _prefs.get(PrefsConstants.user);

      if (tokenJson.isEmpty) {
        return null;
      }
      // Decode JSON string to Map
      final Map<String, dynamic> userMap = jsonDecode(tokenJson);

      // Convert Map to UserModel
      return UserModel.fromJson(userMap);
    } catch (e) {
      // Handle any errors during decoding or mapping
      print('Failed to get user: $e');
      return null;
    }
  }

  Future<AuthenticationModel?> getToken() async {
    try {
      // Retrieve JSON string from Prefs
      final String tokenJson = await _prefs.get(PrefsConstants.authentication);

      if (tokenJson.isEmpty) {
        return null;
      }

      // Decode JSON string to Map
      final Map<String, dynamic> authMap = jsonDecode(tokenJson);

      // Convert Map to UserModel
      return AuthenticationModel.fromJson(authMap);
    } catch (e) {
      // Handle any errors during decoding or mapping
      print('Failed to get user: $e');
      return null;
    }
  }
}
