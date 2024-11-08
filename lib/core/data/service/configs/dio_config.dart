import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';

// dio config
class DioConfig extends GetxService {
  late Dio _dio;

  Future<DioConfig> init() async {
    final String baseUrl = dotenv.env['BASE_URL'] ?? "";
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,  // Base URL from .env
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ));


    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String token = await AuthUseCase.getAuthToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        print("Error: ${error.response?.statusCode} - ${error.message}");
        return handler.next(error);
      },
    ));

    return this;
  }

  Dio get dio => _dio;
}
