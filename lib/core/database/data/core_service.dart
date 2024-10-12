import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/service/configs/dio_config.dart';

class CoreService {
  final DioConfig dioService = DioConfig();

  CoreService() {
    dioService.init();
  }

  Future<Result<T>> fetchData<T, R>({
    required String endpoint,
    required T Function(dynamic data) parse,
  }) async {
    try {
      await dioService.init();
      final response = await dioService.dio.get(endpoint);
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
