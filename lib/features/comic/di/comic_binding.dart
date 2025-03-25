import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/bookcase/data/sources/book_case_service.dart';
import 'package:reading_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:reading_app/features/category/data/sources/category_comic_service.dart';
import 'package:reading_app/features/category/domain/repositories/category_repository.dart';
import 'package:reading_app/features/category/domain/usecase/check_category_cache_usecase.dart';
import 'package:reading_app/features/category/domain/usecase/fetch_categories_cache_usecase.dart';
import 'package:reading_app/features/comic/data/repositories/comic_detail_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_read_repository_impl.dart';
import 'package:reading_app/features/comic/data/repositories/comic_repository_impl.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_detail_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_read_repository.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_repository.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_chapter_comic_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comic_by_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comments_comic_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_home_data_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';
import 'package:reading_app/features/comic/presentation/comic_collection/controller/comic_collection_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_detail/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/comic/presentation/comic_read/controllers/read_comic_controller.dart';
import 'package:reading_app/features/comment/data/sources/comment_comic_service.dart';
import 'package:reading_app/features/comment/data/sources/comment_service.dart';
import 'package:reading_app/features/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
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

    Get.put(
      LayoutBookDetailController(),
    );
    Get.lazyPut(
      () => ComicDetailController(
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
      () => CommentService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => BookCaseService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<ComicDetailRepository>(
      () => ComicDetailRepositoryImpl(
        Get.find(),
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
    Get.lazyPut<CommentComicService>(
      () => CommentComicService(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => ReadComicController(
        Get.find(),
      ),
    );
    Get.lazyPut<ComicReadRepository>(
      () => ComicReadRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchChapterComicUsecase(
        Get.find(),
      ),
    );
  }
}
