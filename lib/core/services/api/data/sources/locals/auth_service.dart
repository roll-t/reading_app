import 'package:reading_app/core/services/api/data/entities/dto/request/introspect_request.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/introspect_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class AuthService extends ApiService {
  AuthService(super.dioConfig, super.cacheService);


  Future<Result<AuthenticationModel>?> token(
      {required UserModel userModel}) async {
    final body = userModel.toJson();
    return await post(
        endpoint: EndPointSetting.tokenEndpoint,
        parse: (data) => AuthenticationModel.fromJson(data),
        data: body);
  }

  Future<Result<IntrospectResponse>> introspect(
      {required IntrospectRequest request}) async {
    return await post(
        endpoint: EndPointSetting.introspect,
        parse: (data) => IntrospectResponse.fromJson(data),
        data: request.toJson());
  }
}
