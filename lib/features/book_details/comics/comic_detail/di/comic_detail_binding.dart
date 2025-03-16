import 'package:get/get.dart';
import 'package:reading_app/features/book_details/comics/comic_detail/data/repositories/comic_detail_repository_impl.dart';
import 'package:reading_app/features/book_details/comics/comic_detail/domain/repositories/comic_detail_repository.dart';
import 'package:reading_app/features/book_details/comics/comic_detail/domain/usecase/fetch_comic_by_slug_usecase.dart';
import 'package:reading_app/features/book_details/comics/comic_detail/domain/usecase/fetch_comments_comic_usecase.dart';
import 'package:reading_app/features/book_details/comics/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/book_details/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/features/bookcase/data/sources/book_case_service.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comment/data/sources/comment_comic_service.dart';
import 'package:reading_app/features/comment/data/sources/comment_service.dart';

class ComicDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LayoutBookDetailController());
    Get.lazyPut(() => ComicDetailController(Get.find(), Get.find()));
    Get.lazyPut(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut(() => CommentService(Get.find(), Get.find()));
    Get.lazyPut(() => BookCaseService(Get.find(), Get.find()));
    Get.lazyPut<ComicDetailRepository>(
        () => ComicDetailRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => FetchComicBySlugUsecase(Get.find()));
    Get.lazyPut(() => FetchCommentsComicUsecase(Get.find()));
    Get.lazyPut<CommentComicService>(
        () => CommentComicService(Get.find(), Get.find()));
  }
}
