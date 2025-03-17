import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/bookcase/data/sources/book_case_service.dart';
import 'package:reading_app/features/category/data/sources/category_service.dart';
import 'package:reading_app/features/category/domain/usecase/check_category_cache_usecase.dart';
import 'package:reading_app/features/comment/data/sources/comment_service.dart';
import 'package:reading_app/features/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/features/novel/data/repositories/novel_detail_repository_impl.dart';
import 'package:reading_app/features/novel/data/sources/chapter_service.dart';
import 'package:reading_app/features/novel/domain/repositories/novel_detail_repository.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_all_category_usecase.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_all_comment_of_novel_usecase.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_chapters_of_novel_usecase.dart';
import 'package:reading_app/features/novel/domain/usecase/fetch_novel_by_id_usecase.dart';
import 'package:reading_app/features/novel/presentation/novel_detail/controllers/novel_detail_controller.dart';
import 'package:reading_app/features/novel/presentation/novel_read/controllers/read_novel_cotroller.dart';

class NovelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    //Service
    Get.lazyPut(
      () => CommentService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CategoryService(
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
    Get.lazyPut(
      () => ChapterService(
        Get.find(),
        Get.find(),
      ),
    );

    // Usecase
    Get.lazyPut(
      () => FetchAllCategoryUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchAllCommentOfNovelUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchChaptersOfNovelUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => CheckCategoryCacheUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchNovelByIdUsecase(
        Get.find(),
      ),
    );

    // repository
    Get.lazyPut<NovelDetailRepository>(
      () => NovelDetailRepositoryImpl(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );

    // Controller
    Get.lazyPut(
      () => ReadNovelController(),
    );
    Get.lazyPut(
      () => NovelDetailController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(() => LayoutBookDetailController());
  }
}
