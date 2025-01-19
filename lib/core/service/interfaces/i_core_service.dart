import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/data/model/result.dart';

abstract class ICoreService {
  Future<Result<T>> request<T>({
    required String method,
    required String endpoint,
    dynamic data,
    required T Function(dynamic data) parse,
    bool useCache = true,
    Duration cacheDuration = const Duration(minutes: 3),
    required ApiSource apiSource,
  });
}
