import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "⏳ Kết nối bị timeout, vui lòng thử lại.";
        case DioExceptionType.sendTimeout:
          return "🚀 Gửi yêu cầu quá lâu, vui lòng thử lại.";
        case DioExceptionType.receiveTimeout:
          return "📥 Nhận phản hồi quá lâu, vui lòng thử lại.";
        case DioExceptionType.badResponse:
          return _handleBadResponse(error);
        case DioExceptionType.cancel:
          return "❌ Yêu cầu đã bị hủy.";
        case DioExceptionType.unknown:
        default:
          return "⚠️ Đã xảy ra lỗi không xác định.";
      }
    } else {
      return "⚠️ Lỗi không xác định: ${error.toString()}";
    }
  }

  static String _handleBadResponse(DioException error) {
    int? statusCode = error.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          return "🚨 Lỗi 400: Yêu cầu không hợp lệ.";
        case 401:
          return "🔑 Lỗi 401: Bạn chưa đăng nhập.";
        case 403:
          return "🚫 Lỗi 403: Bạn không có quyền truy cập.";
        case 404:
          return "🔍 Lỗi 404: Không tìm thấy dữ liệu.";
        case 500:
          return "🔥 Lỗi 500: Lỗi máy chủ, vui lòng thử lại sau.";
        default:
          return "⚠️ Lỗi $statusCode: ${error.response?.statusMessage}";
      }
    }
    return "⚠️ Lỗi phản hồi không xác định.";
  }
}
