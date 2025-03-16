import 'package:get/get.dart';
import 'package:reading_app/features/category/data/repositories/comic_category_repository_impl.dart';
import 'package:reading_app/features/category/domain/repositories/comic_category_repository.dart';
import 'package:reading_app/features/category/domain/usecase/fetch_comic_recommend_usecase.dart';
import 'package:reading_app/features/category/domain/usecase/fetch_comics_by_slug_category_usecase.dart';
import 'package:reading_app/features/category/domain/usecase/fetch_comics_by_slug_usecase.dart';
import 'package:reading_app/features/category/presentation/comic/controllers/category_comic_controller.dart';
import 'package:reading_app/features/category/presentation/novel/controller/category_novel_controller.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // services
    Get.lazyPut(() => ComicApi(Get.find(), Get.find()));

    // repositories
    Get.lazyPut<ComicCategoryRepository>(
        () => ComicCategoryRepositoryImpl(Get.find()));

    // useCases
    Get.lazyPut(() => FetchComicRecommendUsecase(Get.find()));
    Get.lazyPut(() => FetchComicsBySlugCategoryUsecase(Get.find()));
    Get.lazyPut(() => FetchComicsBySlugUsecase(Get.find()));

    // controllers
    Get.lazyPut(() => CategoryController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => CategoryNovelController());
  }
}
