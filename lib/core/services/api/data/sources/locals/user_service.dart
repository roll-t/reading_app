import 'dart:async';

import 'package:reading_app/core/services/api/data/entities/dto/request/user_request_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class UserService extends ApiService {
  UserService(super.dioConfig, super.cacheService);

  Future<Result<UserModel>?> fetchUser({required String uid}) async {
    return await get(
        endpoint: EndPointSetting.getUserEndpoint(uid: uid),
        parse: (data) => UserModel.fromJson(data));
  }

  Future<Result<UserModel>> updateUser(
      {required String uid, required Map<String, dynamic> request}) async {
    return await put(
        endpoint: EndPointSetting.getUserEndpoint(uid: uid),
        parse: (data) => UserModel.fromJson(data),
        data: request);
  }

  Future<Result<UserModel>?> signInAPI(
      {required UserRequestModel userRequest}) async {
    return await post(
        endpoint: EndPointSetting.signInEndpoint,
        parse: (data) => UserModel.fromJson(data),
        data: userRequest.toJson());
  }

  Future<Result<bool>> fetchEmailExist({required String email}) async {
    return await get(
        endpoint: EndPointSetting.emailExistEndpoint(email: email),
        parse: (data) => true);
  }
}
