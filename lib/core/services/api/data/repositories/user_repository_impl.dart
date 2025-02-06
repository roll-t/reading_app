import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/user_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/user_repository.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class UserRepositoryImpl implements UserRepository {
  final Prefs _prefs;
  final UserService _userApiService;
  final String _key = PrefsConstants.user;

  UserRepositoryImpl(this._prefs, this._userApiService);

  @override
  Future<UserModel?> getUser() async {
    var value = await _prefs.get(_key);
    return value.isNotEmpty ? UserModel.fromJson(jsonDecode(value)) : null;
  }

  @override
  Future<void> setUser(UserModel user) async {
    await _prefs.set(PrefsConstants.user, jsonEncode(user.toJson()));
  }

  @override
  Future<void> rememberUser(UserModel user) async {
    await _prefs.set(PrefsConstants.rememberAccount, user.toJson());
  }

  @override
  Future<UserModel?> getRememberUser() async {
    var value = await _prefs.get(PrefsConstants.rememberAccount);
    return value.isNotEmpty ? UserModel.fromJson(jsonDecode(value)) : null;
  }

  @override
  Future<UserModel?> fetchUser(String uid) async {
    try {
      final response = await _userApiService.fetchUser(uid: uid);
      if (response != null && response.status == Status.success) {
        return response.data;
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  @override
  Future<UserModel?> signInWithGoogle(UserRequest request) {
    throw UnimplementedError();
  }
}
