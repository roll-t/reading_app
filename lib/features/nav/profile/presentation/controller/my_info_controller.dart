

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyInfoController extends GetxController{
    Future<bool> isImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'] ?? '';
        return contentType.startsWith('image/');
      }
    } catch (e) {
      // Xử lý lỗi nếu có, ví dụ: không thể gửi yêu cầu
      print('Error: $e');
    }
    return false;
  }
}