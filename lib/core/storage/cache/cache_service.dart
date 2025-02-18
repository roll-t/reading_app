import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:reading_app/core/configs/enum.dart';

class CacheService {
  final CacheManager _cacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  Future<dynamic> getFromCache(String endpoint, ApiSource apiSource) async {
    try {
      String cacheKey = _generateCacheKey(endpoint, apiSource);
      final fileInfo = await _cacheManager.getFileFromCache(cacheKey);
      if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
        final cachedData = await fileInfo.file.readAsString();
        return json.decode(cachedData);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> saveToCache(String endpoint, dynamic data, Duration duration,
      ApiSource apiSource) async {
    try {
      String cacheKey = _generateCacheKey(endpoint, apiSource);
      final jsonData = json.encode(data);
      await _cacheManager.putFile(
        cacheKey,
        utf8.encode(jsonData),
        fileExtension: 'json',
      );
    } catch (e) {
      print("Lỗi khi lưu dữ liệu vào cache: $e");
    }
  }

  String _generateCacheKey(String endpoint, ApiSource apiSource) {
    return '$endpoint-${apiSource.name}';
  }
}
