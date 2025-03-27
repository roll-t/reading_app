import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/comic/data/entities/arguments/category_agrument.dart';

class NavigatorHomePage {

  // to category page function
  static void toCategoryPage(
    CategoryArgument arguments,
  ) {
    Get.toNamed(Routes.category, arguments: arguments);
  }

  //to book details page function
  static void toComicDetailsPage(
    CategoryArgument arguments,
  ) {
    Get.toNamed(Routes.comicDetail);
  }

  //to search page function
  static void toSearchPage() {
    Get.toNamed(Routes.explore);
  }
}
