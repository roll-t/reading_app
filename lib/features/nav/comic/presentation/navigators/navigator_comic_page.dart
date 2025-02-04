import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/materials/categories/comics/data/models/category_arument_model.dart';

class NavigatorComicPage {

  static void toSearchPage(){
    Get.toNamed(Routes.search);
  }

  // to category page function
  static void toCategoryPage(
    CategoryArgumentModel arguments,
  ) {
    Get.toNamed(Routes.category, arguments: arguments);
  }

  static void toCategoryRecommendPage() {
    Get.toNamed(Routes.category, arguments: CategoryArgumentModel(slug: "de-xuat"));
  }
}
