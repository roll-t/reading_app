import 'package:dio/dio.dart';
import 'package:reading_app/core/database/data/model/authentication_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/data/model/user_model.dart';
import 'package:reading_app/core/database/dto/response/response_api.dart';
import 'package:reading_app/core/database/service/configs/end_point_setting.dart';

class AuthApi extends EndPointSetting{
  final Dio _dio;
  AuthApi(this._dio);

  Future<Result<AuthenticationModel>?> token({required UserModel userModel}) async {
    try {
      final response = await _dio.post(EndPointSetting.tokenEndpoint,
        data: userModel.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Xác định kiểu dữ liệu của body
          },
        ),
      );
      return ResponseApi.handleResponseAUthentication(response.statusCode ?? 500,data: response.data['result'] as Map<String, dynamic>);
    } catch (e) {
      print('Exception: $e');
    }
    return null;
  }
}
