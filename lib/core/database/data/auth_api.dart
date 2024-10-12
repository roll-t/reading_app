import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/core_service.dart';
import 'package:reading_app/core/database/data/model/authentication_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/data/model/user_model.dart';
import 'package:reading_app/core/database/dto/request/introspect_request.dart';
import 'package:reading_app/core/database/dto/response/introspect_response.dart';
import 'package:reading_app/core/database/service/configs/end_point_setting.dart';

class AuthApi extends CoreService {
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
