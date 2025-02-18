import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
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

  Future<String?> getToken() async {
    try {
      // Retrieve JSON string from Prefs
      final String tokenJson = await _prefs.get(PrefsConstants.authentication);

      return tokenJson;
    } catch (e) {
      // Handle any errors during decoding or mapping
      print('Failed to get user: $e');
      return null;
    }
  }
}
