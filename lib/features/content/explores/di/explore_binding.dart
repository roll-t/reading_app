import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/repositories/category_repository_impl.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/category_comic_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/category_repository.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/set_categories_cache_usecase.dart';
import 'package:reading_app/features/content/explores/data/repositories/explore_repository_impl.dart';
import 'package:reading_app/features/content/explores/domain/repositories/explore_repository.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novel_by_category_slug_and_status_slug_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novels_by_category_slug_usecase.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_comic_type_controller.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_controller.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_novel_type_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    //service
    Get.lazyPut(() => NovelService(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut(() => ComicApi(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut(() => CategoryComicService(
          Get.find(),
          Get.find(),
        ));

    //repository
    Get.lazyPut<ExploreRepository>(
      () => ExploreRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        Get.find(),
      ),
    );

    //usecase
    Get.lazyPut(
      () => CheckCategoryCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchNovelsByCategorySlugUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchNovelByCategorySlugAndStatusSlugUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchCategoriesCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SetCategoriesCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchComicsByCategorySlugUsecase(
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => ExploreController(),
    );

    Get.lazyPut(() => ExploreComicTypeController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut(
      () => ExploreNovelTypeController(
        Get.find(),
        Get.find(),
      ),
    );
  }
}
