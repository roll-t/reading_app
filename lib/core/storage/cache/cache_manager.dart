import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static Future<int> getLastCacheTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cache_time') ?? 0;
  }

  static Future<void> saveCacheTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('cache_time', currentTime);
  }

  static Future<void> deleteCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final cachePath = cacheDir.path;
      final cacheDirectory = Directory(cachePath);

      if (cacheDirectory.existsSync()) {
        cacheDirectory.deleteSync(recursive: true);
        print('Cache deleted successfully');
      }
    } catch (e) {
      print('Error deleting cache: $e');
    }
  }

  static Future<bool> isCacheExpired() async {
    final lastCacheTime = await getLastCacheTime();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDifference = currentTime - lastCacheTime;

    return timeDifference > 3 * 60 * 1000; // thời gian caching khoảng 3p
  }

  static Future<int> getCacheSize() async {
    int totalSize = 0;

    try {
      final cacheDir = await getTemporaryDirectory();
      final cachePath = cacheDir.path;
      final cacheDirectory = Directory(cachePath);

      if (cacheDirectory.existsSync()) {
        final cacheFiles =
            cacheDirectory.listSync(recursive: true, followLinks: false);
        for (var file in cacheFiles) {
          if (file is File) {
            totalSize += await file.length();
          }
        }
      }
    } catch (e) {
      print('Error calculating cache size: $e');
    }

    return totalSize;
  }
}
