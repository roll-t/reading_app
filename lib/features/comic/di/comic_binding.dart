import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:reading_app/features/category/data/sources/category_comic_service.dart';
import 'package:reading_app/features/category/domain/repositories/category_repository.dart';
import 'package:reading_app/features/category/domain/usecase/check_category_cache_usecase.dart';
import 'package:reading_app/features/category/domain/usecase/fetch_categories_cache_usecase.dart';
import 'package:reading_app/features/comic/data/repositories/comic_repository_impl.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_repository.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_home_data_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';
import 'package:reading_app/features/comic/presentation/comic_collection/controller/comic_collection_controller.dart';
import 'package:reading_app/features/novel/data/sources/novel_service.dart';

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => Prefs(),
      fenix: true,
    );
    Get.lazyPut<ComicApi>(
      () => ComicApi(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<CategoryComicService>(
      () => CategoryComicService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<ComicRepository>(
      () => ComicRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut<NovelService>(
      () => NovelService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<FetchHomeDataUsecase>(
      () => FetchHomeDataUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CheckCategoryCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut<FetchListComicByStatusUsecase>(
      () => FetchListComicByStatusUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut<FetchComicsByCategorySlugUsecase>(
      () => FetchComicsByCategorySlugUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CategoryComicService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchCategoriesCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ComicCollectionController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
