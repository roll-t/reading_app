import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/service/configs/dio_config.dart';

class CoreService {
  final DioConfig dioService = DioConfig();

  CoreService() {
    dioService.init();
  }

  Future<Result<T>> request<T>({
    required String method,
    required String endpoint,
    dynamic data,
    required T Function(dynamic data) parse,
  }) async {
    try {
      await dioService.init();
      final response = await _makeRequest(method, endpoint, data);
      return _handleResponse<T>(response, parse);
    } catch (e) {
      return Result.error(ApiError.badRequest);
    }
  }

  Future<dynamic> _makeRequest(String method, String endpoint, dynamic data) {
    return method == 'POST'
        ? dioService.dio.post(endpoint, data: data)
        : dioService.dio.get(endpoint);
  }

  Result<T> _handleResponse<T>(dynamic response, T Function(dynamic data) parse) {
    if (response.statusCode == 200) {
      final data = response.data["result"];
      return Result.success(parse(data));
    } else {
      return Result.error(ApiError.badRequest);
    }
  }

  Future<Result<T>> fetchData<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
  }) async {
    return request(method: 'GET', endpoint: endpoint, parse: parse);
  }

  Future<Result<T>> postData<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
  }) async {
    return request(method: 'POST', endpoint: endpoint, data: data, parse: parse);
  }
}
