import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/service/configs/dio_config.dart';

class ServiceApi {
  final DioConfig _dioConfig = DioConfig();

  // Constructor nếu cần khởi tạo các thành phần liên quan
  ServiceApi();

  Future<Result<T>> fetchData<T, R>({
    required String endpoint,
    required T Function(dynamic data) parse,
  }) async {
    try {
      await _dioConfig.init();
      final response = await _dioConfig.dio.get(endpoint);
      if (response.statusCode == 200) {
        final data = response.data["result"];
        return Result.success(parse(data));
      } else {
        return Result.error(ApiError.badRequest);
      }
    } catch (e) {
      return Result.error(ApiError.badRequest);
    }
  }
}
