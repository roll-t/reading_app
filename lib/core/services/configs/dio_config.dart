import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/domain/auth_use_case.dart';

class DioConfig extends GetxService {
  late Dio _dio;

  Future<DioConfig> init() async {
    final String baseUrl = dotenv.env['BASE_URL'] ?? "";
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,  // Base URL from .env
      connectTimeout: const Duration(seconds: 10),  // Connection timeout
      receiveTimeout: const Duration(seconds: 15),  // Receive timeout
      headers: {
        "Content-Type": "application/json",  // Default content type
      },
    ));

    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the token before sending the request
        String token = await AuthUseCase.getAuthToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token'; // Set token dynamically
        }
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        // Optionally handle responses here
        // print("Response: ${response.statusCode} ${response.data}");
        return handler.next(response); // Continue with the response
      },
      onError: (DioException error, handler) {
        // Handle errors here (log, show message, etc.)
        print("Error: ${error.response?.statusCode} - ${error.message}");
        return handler.next(error); // Continue with the error
      },
    ));

    return this; // Return the DioConfig instance
  }

  Dio get dio => _dio; // Getter for Dio instance
}
