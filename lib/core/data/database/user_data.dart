import 'dart:async';

import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/database/model/user_model.dart';
import 'package:reading_app/core/data/database/model/user_request_model.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class UserData extends CoreService {
  UserData._privateConstructor();
  static final UserData _instance = UserData._privateConstructor();
  factory UserData() {
    return _instance;
  }
  Future<Result<UserModel>?> fetchUser({required String uid}) async {
    return await fetchData(
        endpoint: EndPointSetting.getUserEndpoint(uid: uid),
        parse: (data) => UserModel.fromJson(data));
  }

  Future<Result<UserModel>?> signInAPI(
      {required UserRequestModel userRequest}) async {
    return await postData(
        endpoint: EndPointSetting.signInEndpoint,
        parse: (data) => UserModel.fromJson(data),
        data: userRequest.toJson());
  }

  Future<Result<bool>> fetchEmailExist({required String email}) async {
    return await fetchData(
        endpoint: EndPointSetting.emailExistEndpoint(email: email),
        parse: (data) => true);
  }

  static Future<Result<UserModel>?> getUser({required String uid}) async {
    return await UserData().fetchUser(uid: uid);
  }

  static Future<Result<bool>> emailExist({required String email}) async {
    return await UserData().fetchEmailExist(email: email);
  }
}
