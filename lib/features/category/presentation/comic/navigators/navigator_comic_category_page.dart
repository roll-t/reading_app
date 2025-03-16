

import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/category/data/models/category_arument_model.dart';

class NavigatorComicCategoryPage {
  
  //to book details page function
  static void toComicDetailsPage(
    CategoryArgumentModel arguments,
  ) {
    Get.toNamed(Routes.comicDetail);
  }

}
