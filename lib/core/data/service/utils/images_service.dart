import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class ImagesService extends CoreService {
  // Check if the image URL exists
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
      return await postData<Map<String, String>>(
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
        'http://14.225.218.46:8080/images/upload',
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
      // Assuming the payload has 'imageId' key
      final imagePublicId = payload['imageId'];

      // Make sure imagePublicId is not empty
      if (imagePublicId == null || imagePublicId.isEmpty) {
        throw Exception('Invalid image ID');
      }

      final formatPublicId = imagePublicId.replaceAll('/', '-');
      var dio = Dio();
      String token = await AuthUseCase.getAuthToken();
      var response = await dio.delete(
        'http://14.225.218.46:8080/images/delete/$formatPublicId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Check if the response is a Map or just a String message
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          // If the response is a string (success message)
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
