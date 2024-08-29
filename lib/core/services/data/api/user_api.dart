import 'package:dio/dio.dart';
import 'package:reading_app/core/data/models/result.dart';
import 'package:reading_app/core/services/data/model/user_model.dart';
import 'package:reading_app/core/services/server/end_point_setting.dart';

class UserApi {
  final Dio _dio;
  UserApi(this._dio);
  Future<Result<UserModel>?> fetchUser({required String uid}) async {
    try {
      final response =
          await _dio.get(EndPointSetting.getUserEndpoint(uid: uid));
      if (response.statusCode == 200) {
        final data = response.data["result"];
        final userModel = UserModel.fromJson(data);
        return Result.success(userModel);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Result<UserModel>?> signInAPI({required String userRequest}) async {
    try {
      final response = await _dio.post(
        EndPointSetting.signInEndpoint(),
        data: userRequest,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      if(response.statusCode==200){
        final data = response.data["result"];
        final userModel = UserModel.fromJson(data);
        return Result.success(userModel);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Result<UserModel>?> getUser({required String uid}) async {
    final dataRemote = UserApi(Dio());
    return await dataRemote.fetchUser(uid: uid);
  }

  static Future<Result<UserModel>?> signIn({required String userRequest})async{
    final dataRemote = UserApi(Dio());
    return await dataRemote.signInAPI(userRequest: userRequest);
  }
}
