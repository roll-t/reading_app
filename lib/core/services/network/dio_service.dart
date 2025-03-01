import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/get_auth_token_usecase.dart';
import 'package:reading_app/core/services/network/error_handler.dart';

class DioConfig extends GetxService {
  late Dio _dio;
  final GetAuthTokenUseCase _getAuthTokenUseCase;

  DioConfig(this._getAuthTokenUseCase);

  Future<DioConfig> init() async {
    final String baseUrl = dotenv.env['BASE_URL'] ?? "";
    if (baseUrl.isEmpty) {
      throw Exception("BASE_URL is not defined in .env file");
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getAuthTokenUseCase();
        log(token ?? "");
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          print("Warning: Token is empty");
        }
        handler.next(options);
      },
      onError: (DioException error, handler) {
        final handledError = ErrorHandler.handleError(error);
        print("API Error: $handledError");

        handler.reject(error);
      },
    ));

    return this;
  }

  Dio get dio => _dio;
}
