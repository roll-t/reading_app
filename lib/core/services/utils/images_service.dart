import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class ImagesService extends ApiService {
  ImagesService(super.dioConfig, super.cacheService);

  static Future<bool> doesImageLinkExist(String url) async {
    try {
      final response = await Dio().head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Upload image using Dio
  Future<Result<Map<String, String>>> uploadImage(
      {required File request}) async {
    String fileName = request.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(request.path, filename: fileName),
    });

    try {
      return await post<Map<String, String>>(
        endpoint: EndPointSetting.uploadImage,
        data: formData,
        parse: (data) {
          return data['url'] ?? '';
        },
      );
    } catch (e) {
      return Result.error(ApiError.badRequest);
    }
  }

  static Future<Map<String, dynamic>> handleUpload(File file) async {
    try {
      var dio = Dio();
      String token = await AuthUseCase.getAuthToken();
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });

      var response = await dio.post(
        EndPointSetting.uploadImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data
            as Map<String, dynamic>; // Returning the response data as a Map
      }

      return {
        'error': 'Failed to upload image, status: ${response.statusCode}'
      };
    } catch (error) {
      print("Error uploading image: $error");
      return {'error': 'Error uploading image: $error'};
    }
  }

  static Future<Map<String, dynamic>> handleDelete(
      Map<String, dynamic> payload) async {
    try {
      final imagePublicId = payload['imageId'];

      if (imagePublicId == null || imagePublicId.isEmpty) {
        throw Exception('Invalid image ID');
      }

      final formatPublicId = imagePublicId.replaceAll('/', '-');
      var dio = Dio();
      String token = await AuthUseCase.getAuthToken();
      var response = await dio.delete(
        '${EndPointSetting.deleteImage}/$formatPublicId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          return {'message': response.data};
        } else {
          return {'error': 'Unexpected response format: ${response.data}'};
        }
      }

      return {
        'error': 'Failed to delete image, status: ${response.statusCode}'
      };
    } catch (error) {
      print("Error deleting image: $error");
      return {'error': 'Error deleting image: $error'};
    }
  }
}
