import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/authentication_model.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/database/model/user_model.dart';
import 'package:reading_app/core/data/dto/request/introspect_request.dart';
import 'package:reading_app/core/data/dto/response/introspect_response.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class AuthData extends CoreService {
  Future<Result<AuthenticationModel>?> token(

      {required UserModel userModel}) async {
    try {
      final response = await dioService.dio.post(
        EndPointSetting.tokenEndpoint,
        data: userModel.toJson(),
      );
      if (response.statusCode == 200) {
        if (response.data['result'] != null) {
          return Result.success(AuthenticationModel.fromJson(response.data['result']));
        }
      }
    } catch (e) {
      print('Exception: $e');
    }
    return null;
  }

  Future<Result<IntrospectResponse>> introspect(
      {required IntrospectRequest request}) async {
    try {
      var response = await dioService.dio
          .post(EndPointSetting.introspect, data: request.toJson());
      if (response.statusCode == 200) {
        if (response.data["result"] != null) {
          return Result.success(
              IntrospectResponse.fromJson(response.data["result"]));
        }
      }
      return Result.error(ApiError.badRequest);
    } catch (e) {
      return Result.error(ApiError.badRequest);
    }
  }
}
