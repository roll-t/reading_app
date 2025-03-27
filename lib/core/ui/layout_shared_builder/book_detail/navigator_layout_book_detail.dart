import 'package:get/get.dart';
import 'package:reading_app/features/comic/data/entities/arguments/category_agrument.dart';

class NavigatorLayoutBookDetail {
  static Future<dynamic>? toCategoryPage(
    String route,
    CategoryArgument arguments,
  ) {
    return Get.offAndToNamed(route, arguments: arguments);
  }
}
