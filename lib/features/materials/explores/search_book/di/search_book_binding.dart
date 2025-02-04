import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/category_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/features/materials/explores/search_book/presentation/controller/search_book_controller.dart';

class SearchBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckCategoryCacheUsecase(Get.find()));
    Get.lazyPut(() => CategoryService(Get.find(), Get.find()));
    Get.lazyPut(() => ComicApi(Get.find(), Get.find()));
    Get.put(SearchBookController());
  }
}
