import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/comic/data/entities/arguments/category_agrument.dart';

class NavigatorComicPage {
  static void toSearchPage() {
    Get.toNamed(Routes.explore);
  }

  // to category page function
  static void toCategoryPage(
    CategoryArgument arguments,
  ) {
    Get.toNamed(Routes.category, arguments: arguments);
  }

  static void toCategoryRecommendPage() {
    Get.toNamed(Routes.category, arguments: CategoryArgument(slug: "de-xuat"));
  }

  //to book details page function
  static void toComicDetailsPage(
    CategoryArgument arguments,
  ) {
    Get.toNamed(Routes.comicDetail);
  }
}
