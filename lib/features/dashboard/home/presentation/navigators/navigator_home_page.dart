import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';

class NavigatorHomePage {

  // to category page function
  static void toCategoryPage(
    CategoryArgumentModel arguments,
  ) {
    Get.toNamed(Routes.category, arguments: arguments);
  }

  //to book details page function
  static void toComicDetailsPage(
    CategoryArgumentModel arguments,
  ) {
    Get.toNamed(Routes.comicDetail);
  }

  //to search page function
  static void toSearchPage() {
    Get.toNamed(Routes.search);
  }
}
