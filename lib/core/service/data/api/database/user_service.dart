import 'dart:async';

import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/dto/request/user_request_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';

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

  Future<Result<UserModel>> updateUser(
      {required String uid, required Map<String, dynamic> request}) async {
    return await putData(
        endpoint: EndPointSetting.getUserEndpoint(uid: uid),
        parse: (data) => UserModel.fromJson(data),
        data: request);
  }

  Future<Result<UserModel>?> signInAPI(
      {required UserRequestModel userRequest}) async {
    print(EndPointSetting.signInEndpoint);
    print(userRequest.toJson());
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
