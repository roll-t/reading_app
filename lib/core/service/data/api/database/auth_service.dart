import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/dto/request/introspect_request.dart';
import 'package:reading_app/core/service/data/dto/response/introspect_response.dart';
import 'package:reading_app/core/service/data/model/authentication_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';

class AuthData extends CoreService {
  Future<Result<AuthenticationModel>?> token(
      {required UserModel userModel}) async {
    final body = userModel.toJson();
    return await postData(
        endpoint: EndPointSetting.tokenEndpoint,
        parse: (data) => AuthenticationModel.fromJson(data),
        data: body);
  }

  Future<Result<IntrospectResponse>> introspect(
      {required IntrospectRequest request}) async {
    return await postData(
        endpoint: EndPointSetting.introspect,
        parse: (data) => IntrospectResponse.fromJson(data),
        data: request.toJson());
  }
}
