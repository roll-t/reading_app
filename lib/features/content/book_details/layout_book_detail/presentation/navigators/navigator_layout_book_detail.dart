import 'package:get/get.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';

class NavigatorLayoutBookDetail {
  static Future<dynamic>? toCategoryPage(
    String route,
    CategoryArgumentModel arguments,
  ) {
    return Get.offAndToNamed(route, arguments: arguments);
  }
}
