import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/core_service.dart';

class ApiService extends CoreService {
  ApiService(super.dioConfig, super.cacheService);
  Future<Result<T>> get<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
    bool useCache = true,
    Duration cacheDuration = const Duration(minutes: 3),
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: RequestApi.GET.name,
      endpoint: endpoint,
      parse: parse,
      useCache: useCache,
      cacheDuration: cacheDuration,
      apiSource: apiSource,
    );
  }

  // Post data with POST method
  Future<Result<T>> post<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: RequestApi.POST.name,
      endpoint: endpoint,
      data: data,
      parse: parse,
      apiSource: apiSource,
    );
  }

  // Put data with PUT method
  Future<Result<T>> put<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: RequestApi.PUT.name,
      endpoint: endpoint,
      data: data,
      parse: parse,
      apiSource: apiSource,
    );
  }

  // Delete data with DELETE method
  Future<Result<T>> delete<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: RequestApi.DELETE.name,
      endpoint: endpoint,
      parse: parse,
      apiSource: apiSource,
    );
  }
}
