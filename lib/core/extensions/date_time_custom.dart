import 'package:intl/intl.dart';

class DateTimeCustom {
  static String currentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
