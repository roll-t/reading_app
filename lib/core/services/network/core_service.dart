import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/dio_service.dart';
import 'package:reading_app/core/storage/cache/cache_service.dart';

class CoreService {
  final DioConfig dioConfig;
  final CacheService cacheService;
  CoreService(this.dioConfig, this.cacheService);

  Future<Result<T>> request<T>({
    required String method,
    required String endpoint,
    dynamic data,
    required T Function(dynamic data) parse,
    bool useCache = true,
    Duration cacheDuration = const Duration(minutes: 3),
    required ApiSource apiSource,
  }) async {
    try {
      dioConfig.init();
      if (method.toUpperCase() == RequestApi.GET.name && useCache) {
        final cachedResponse =
            await cacheService.getFromCache(endpoint, apiSource);
        if (cachedResponse != null) {
          if (apiSource == ApiSource.comic) {
            return Result.success(parse(cachedResponse));
          } else {
            return Result.success(parse(cachedResponse["result"]));
          }
        }
      }

      final response = await _makeRequest(method, endpoint, data);
      if (method.toUpperCase() == RequestApi.GET.name && useCache) {
        await cacheService.saveToCache(
            endpoint, response.data, cacheDuration, apiSource);
      }
      return _parseApiResponse(response, parse, apiSource);
    } catch (e) {
      if (e is DioException) {
        return _handleDioError(e);
      }
      return Result.error(ApiError.serverError);
    }
  }

  Future<Response<dynamic>> _makeRequest(
      String method, String endpoint, dynamic data) async {
    switch (method.toUpperCase()) {
      case 'POST':
        return await dioConfig.dio.post(endpoint, data: data);
      case 'PUT':
        return await dioConfig.dio.put(endpoint, data: data);
      case 'DELETE':
        return await dioConfig.dio.delete(endpoint);
      case "GET":
      default:
        return await dioConfig.dio.get(endpoint);
    }
  }

  Result<T> _handleDioError<T>(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return Result.error(ApiError.badRequest);
      case 401:
        return Result.error(ApiError.unauthorized);
      case 403:
        return Result.error(ApiError.unauthorized);
      case 404:
        return Result.error(ApiError.notFound);
      case 500:
        return Result.error(ApiError.serverError);
      default:
        return Result.error(ApiError.serverError);
    }
  }

  Result<T> _parseApiResponse<T>(Response<dynamic> response,
      T Function(dynamic data) parse, ApiSource apiSource) {
    if (apiSource == ApiSource.local) {
      return Result.success(parse(response.data["result"]));
    } else if (apiSource == ApiSource.comic) {
      return Result.success(parse(response.data));
    }
    return Result.error(ApiError.serverError);
  }
}
