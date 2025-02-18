import 'package:intl/intl.dart';

class DatetimeUtil {
  static String formatDateTimeFormat(DateTime dateTime) {
    String formattedDate = DateFormat('d MMMM, EEEE').format(dateTime);
    return formattedDate;
  }

  static String format(DateTime dateTime) {
    String formattedDate = DateFormat("yyyy-MM-dd'T'00:00:00").format(dateTime);
    return formattedDate;
  }

  static String currentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static String formatCustom(DateTime? dateTime) {
    if (dateTime != null) {
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    } else {
      DateTime now = DateTime.now(); // Lấy thời gian hiện tại
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(now);
    }
  }

  static String timeAgo(DateTime commentTime) {
    final Duration difference = DateTime.now().difference(commentTime);

    if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} tháng trước';
    } else {
      return '${(difference.inDays / 365).floor()} năm trước';
    }
  }
}
