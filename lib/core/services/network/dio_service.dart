import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/error_handler.dart';
import 'package:reading_app/features/auth/domain/usecase/get_auth_token_usecase.dart';

class DioConfig extends GetxService {
  late Dio _dio;

  final GetAuthTokenUseCase _getAuthTokenUseCase;

  DioConfig(
    this._getAuthTokenUseCase,
  );

  final List<String> _excludedEndpoint = [
    APIEndpoint.tokenEndpoint,
    APIEndpoint.introspect,
    APIEndpoint.signInEndpoint,
    APIEndpoint.emailExistEndpoint(email: ""),
    APIEndpoint.getUserEndpoint(uid: ""),
  ];

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

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool keepToken = _excludedEndpoint.any(
            (endpoint) => options.path.startsWith(endpoint),
          );

          // check endpoint use toke
          if (!keepToken) {
            final token = await _getAuthTokenUseCase();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              log("Warning: Token is empty");
            }
          } else {
            log("shipping token for ${options.path}");
          }
          handler.next(options);
        },
        onError: (DioException error, handler) {
          final handledError = ErrorHandler.handleError(error);
          log("API Error: $handledError");
          handler.reject(error);
        },
      ),
    );

    return this;
  }

  Dio get dio => _dio;
}
