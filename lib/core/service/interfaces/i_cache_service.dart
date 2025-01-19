import 'package:reading_app/core/configs/enum.dart';

abstract class ICacheService {
  dynamic getFromCache(String endpoint, ApiSource apiSource);
  void saveToCache(String endpoint, dynamic data, Duration duration, ApiSource apiSource);
}
