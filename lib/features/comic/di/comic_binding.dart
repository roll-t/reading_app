import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/core/ui/layout_shared_builder/book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/core/ui/layout_shared_builder/explore/presentation/controllers/explore_controller.dart';
import 'package:reading_app/features/bookcase/data/sources/book_case_service.dart';
import 'package:reading_app/features/comic/data/repositories/category_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_category_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_detail_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_read_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/explore_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/search_repository_impl.dart';
import 'package:reading_app/features/comic/data/sources/category_comic_service.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/category_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_category_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_detail_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_read_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/explore_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/search_repository.dart';
import 'package:reading_app/features/comic/domain/usecases/category/check_category_cache_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/category/fetch_categories_cache_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/category/set_categories_cache_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_chapter_comic_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comic_by_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comics_search_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comments_comic_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_recomendation_comic_usecase.dart';
import 'package:reading_app/features/comic/presentation/comic_categories/controllers/category_comic_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_collection/controller/comic_collection_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_detail/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_explore/controller/explore_comic_type_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_explore/controller/explore_novel_type_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_read/controllers/read_comic_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_search/controller/search_comic_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_search/controller/search_novel_controller.dart';
import 'package:reading_app/features/comment/data/sources/comment_comic_service.dart';
import 'package:reading_app/features/comment/data/sources/comment_service.dart';
import 'package:reading_app/features/novel/data/sources/novel_service.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_novel_by_category_slug_and_status_slug_usecase.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_novel_search_usecase.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_novels_by_category_slug_usecase.dart';
import 'package:reading_app/features/novel/presentation/novel_category/controller/category_novel_controller.dart';

///**********************************
/// CREATE TIME - 18/03/2025
///
/// **USED IN:**
/// - ` comic feature`
///
/// **EXPLANATION:**
///  Create necessary dependence use on comic features.
///*********************************/

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    // Core Preference cache
    Get.lazyPut(() => Prefs(), fenix: true);

    // ---> Services
    Get.lazyPut(
      () => BookCaseService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CategoryComicService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CommentComicService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CommentService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ComicApi(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => NovelService(
        Get.find(),
        Get.find(),
      ),
    );

    // ---> Repositories
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut<ComicRepository>(
      () => ComicRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut<ComicDetailRepository>(
      () => ComicDetailRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<ComicReadRepository>(
      () => ComicReadRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut<ExploreRepository>(
      () => ExploreRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<SearchRepository>(
      () => SearchRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<ComicCategoryRepository>(
      () => ComicCategoryRepositoryImpl(
        Get.find(),
      ),
    );

    // ---> Use Cases
    Get.lazyPut(
      () => CheckCategoryCacheUsecase(
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
      () => FetchListComicByStatusUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchComicBySlugUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchCommentsComicUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchNovelSearchUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchComicsSearchUsecase(
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
      () => FetchRecommendationComicUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchChapterComicUsecase(
        Get.find(),
      ),
    );

    // ---> Controllers
    Get.lazyPut(
      () => LayoutBookDetailController(),
    );
    Get.lazyPut(
      () => ComicCollectionController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ComicDetailController(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ReadComicController(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ExploreController(),
    );
    Get.lazyPut(
      () => ExploreComicTypeController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ExploreNovelTypeController(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SearchComicController(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SearchNovelController(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CategoryController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CategoryNovelController(),
    );
  }
}
