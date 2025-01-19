import 'package:get/get.dart';
import 'package:reading_app/core/service/api/locals/novel_service.dart';
import 'package:reading_app/core/service/api/remotes/category_service.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';
import 'package:reading_app/core/service/data/repositories/category_repository_impl.dart';
import 'package:reading_app/core/service/domain/repositories/category_repository.dart';
import 'package:reading_app/core/service/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/core/service/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/service/storage/prefs/prefs.dart';
import 'package:reading_app/features/nav/comic/data/repositories/comic_repository_impl.dart';
import 'package:reading_app/features/nav/comic/domain/repositories/comic_repository.dart';
import 'package:reading_app/features/nav/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/nav/comic/domain/usecases/fetch_home_data_usecase.dart';
import 'package:reading_app/features/nav/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';
import 'package:reading_app/features/nav/comic/presentation/controller/comic_controller.dart';

class CommicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<ComicApi>(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut<CategoryService>(() => CategoryService(Get.find(), Get.find()));
    Get.lazyPut<ComicRepository>(() => ComicRepositoryImpl(Get.find()));
    Get.lazyPut<NovelService>(() => NovelService(Get.find(), Get.find()));
    Get.lazyPut<FetchHomeDataUsecase>(() => FetchHomeDataUsecase(Get.find()));
    Get.lazyPut(() => CheckCategoryCacheUsecase(Get.find()));
    Get.lazyPut<FetchListComicByStatusUsecase>(
        () => FetchListComicByStatusUsecase(Get.find()));
    Get.lazyPut<FetchComicsByCategorySlugUsecase>(
        () => FetchComicsByCategorySlugUsecase(Get.find()));
    Get.lazyPut(() => CategoryService(Get.find(), Get.find()));
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()));
    Get.lazyPut(() => FetchCategoriesCacheUsecase(Get.find()));
    Get.lazyPut(
        () => ComicController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
