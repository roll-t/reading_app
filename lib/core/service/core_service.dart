import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/configs/dio_config.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CoreService {
  final DioConfig dioService = DioConfig();
  final _cache = HashMap<String, dynamic>();
  final Logger _logger = Logger();

  CoreService() {
    dioService.init();
  }

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
      _logger.i(
          "Starting request: [Method: $method, Endpoint: $endpoint, Source: $apiSource]");
      await dioService.init();

      //======================= Lấy dữ liệu từ cache ==========================
      if (method.toUpperCase() == 'GET' && useCache) {
        final cachedResponse = _getFromCache(endpoint, apiSource);
        if (cachedResponse != null) {
          _logger.i("Cache hit: [Endpoint: $endpoint, Source: $apiSource]");
          return Result.success(parse(cachedResponse));
        }
        _logger.w("Cache miss: [Endpoint: $endpoint, Source: $apiSource]");
      }

      //================NẾU CACHE KHÔNG TỒN TẠI THÌ TẠO REQUEST ĐỂ LẤY DỮ LIỆU==================
      final response = await _makeRequest(method, endpoint, data);
      _logger.i(
          "API response received: [Endpoint: $endpoint, Status: ${response.statusCode}]");
      if (method.toUpperCase() == 'GET' && useCache) {
        _logger.i(
            "Saving data to cache: [Endpoint: $endpoint, Source: $apiSource]");
        if (apiSource == ApiSource.local) {
          _saveToCache(
              endpoint, response.data["result"], cacheDuration, apiSource);
        } else if (apiSource == ApiSource.comic) {
          _saveToCache(endpoint, response.data, cacheDuration, apiSource);
        }
      }
      //========== ĐỊNH NGHĨA KIỂU DỮ LIỆU TRẢ VỀ ====================
      if (apiSource == ApiSource.local) {
        return Result.success(parse(response.data["result"]));
      } else if (apiSource == ApiSource.comic) {
        return Result.success(parse(response.data));
      }
      return Result.error(ApiError.serverError);
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioException: [Endpoint: $endpoint, Error: ${e.message}]");
        return _handleDioError(e);
      }
      _logger.e("Unhandled error: [Endpoint: $endpoint, Error: $e]");
      return Result.error(ApiError.serverError);
    }
  }

  //================ lƯU THÔNG TIN CACHE ===================
  void _saveToCache(
      String endpoint, dynamic data, Duration duration, ApiSource apiSource) {
    final expiryTime = DateTime.now().add(duration);
    String cacheKey = _generateCacheKey(endpoint, apiSource);
    if (_cache.containsKey(cacheKey) && _cache[cacheKey]['data'] == data) {
      _logger
          .i("Cache data unchanged: [Endpoint: $endpoint, Source: $apiSource]");
      return;
    }
    _cache[cacheKey] = {'data': data, 'expiry': expiryTime};
    _logger.d(
        "Data cached: [Endpoint: $endpoint, Source: $apiSource, Expiry: $expiryTime]");
  }

  //==================== LẤY DỮ LIỆU THỪ CACHE ========================
  dynamic _getFromCache(String endpoint, ApiSource apiSource) {
    String cacheKey = _generateCacheKey(endpoint, apiSource);
    final cachedItem = _cache[cacheKey];
    if (cachedItem != null) {
      final expiryTime = cachedItem['expiry'] as DateTime;
      if (DateTime.now().isBefore(expiryTime)) {
        _logger.d(
            "Cache valid: [Endpoint: $endpoint, Source: $apiSource, Expiry: $expiryTime]");
        return cachedItem['data'];
      } else {
        _logger.w("Cache expired: [Endpoint: $endpoint, Source: $apiSource]");
      }
    }
    _logger.w(
        "No valid cache found for [Endpoint: $endpoint, Source: $apiSource]");
    return null;
  }

  String _generateCacheKey(String endpoint, ApiSource apiSource) {
    return '$endpoint-${apiSource.toString()}';
  }

  // ========== XÁC ĐỊNH PHƯƠNG THỨC =======================
  Future<Response<dynamic>> _makeRequest(
      String method, String endpoint, dynamic data) async {
    _logger.d(
        "Making request: [Method: $method, Endpoint: $endpoint, Data: $data]");
    try {
      switch (method.toUpperCase()) {
        case 'POST':
          return await dioService.dio.post(endpoint, data: data);
        case 'PUT':
          return await dioService.dio.put(endpoint, data: data);
        case 'DELETE':
          return await dioService.dio.delete(endpoint);
        case 'GET':
        default:
          return await dioService.dio.get(endpoint);
      }
    } catch (e) {
      _logger.e("Request error: [Endpoint: $endpoint, Error: $e]");
      rethrow;
    }
  }

  // =========== XÁC ĐỊNH LỖI KHI CALL API ===================
  Result<T> _handleDioError<T>(DioException e) {
    _logger.e(
        "DioException: [Error: ${e.message}, Code: ${e.response?.statusCode}]");
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

  //========= PHƯƠNG THỨC LẤY DỮ LIỆU ==================
  Future<Result<T>> fetchData<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
    bool useCache = true,
    Duration cacheDuration = const Duration(minutes: 3), // Cache 3 phút
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: 'GET',
      endpoint: endpoint,
      parse: parse,
      useCache: useCache,
      cacheDuration: cacheDuration,
      apiSource: apiSource,
    );
  }

  Future<Result<T>> postData<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: 'POST',
      endpoint: endpoint,
      data: data,
      parse: parse,
      apiSource: apiSource,
    );
  }

  Future<Result<T>> putData<T>({
    required String endpoint,
    required dynamic data,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: 'PUT',
      endpoint: endpoint,
      data: data,
      parse: parse,
      apiSource: apiSource,
    );
  }

  Future<Result<T>> deleteData<T>({
    required String endpoint,
    required T Function(dynamic data) parse,
    ApiSource apiSource = ApiSource.local,
  }) async {
    return request(
      method: 'DELETE',
      endpoint: endpoint,
      parse: parse,
      apiSource: apiSource,
    );
  }
}
