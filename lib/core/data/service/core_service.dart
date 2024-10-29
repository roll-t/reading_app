import 'package:dio/dio.dart';
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
      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 400:
            return Result.error(ApiError.badRequest);
          case 401:
            return Result.error(ApiError.unauthorized);
          case 404:
            return Result.error(ApiError.notFound);
          // Add other cases as needed
          default:
            return Result.error(ApiError.serverError);
        }
      }
      return Result.error(ApiError.serverError);
    }
  }

  Future<Response<dynamic>> _makeRequest(
      String method, String endpoint, dynamic data) {
    switch (method.toUpperCase()) {
      case 'POST':
        return dioService.dio.post(endpoint, data: data);
      case 'PUT':
        return dioService.dio.put(endpoint, data: data);
      case 'DELETE':
        return dioService.dio.delete(endpoint);
      case 'GET':
      default:
        return dioService.dio.get(endpoint);
    }
  }

  Result<T> _handleResponse<T>(
      Response<dynamic> response, T Function(dynamic data) parse) {
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
    return request(
        method: 'POST', endpoint: endpoint, data: data, parse: parse);
  }

  Future<Result<T>> putData<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
  }) async {
    return request(method: 'PUT', endpoint: endpoint, data: data, parse: parse);
  }

  Future<Result<T>> deleteData<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
  }) async {
    return request(method: 'DELETE', endpoint: endpoint, parse: parse);
  }
}
