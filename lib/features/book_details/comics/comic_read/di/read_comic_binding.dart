import 'package:get/get.dart';
import 'package:reading_app/features/book_details/comics/comic_read/data/repositories/comic_read_repository_impl.dart';
import 'package:reading_app/features/book_details/comics/comic_read/domain/repositories/comic_read_repository.dart';
import 'package:reading_app/features/book_details/comics/comic_read/domain/usecase/fetch_chapter_comic_usecase.dart';
import 'package:reading_app/features/book_details/comics/comic_read/presentation/controllers/read_comic_controller.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';

class ReadComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut(() => ReadComicController(Get.find()));
    Get.lazyPut<ComicReadRepository>(() => ComicReadRepositoryImpl(Get.find()));
    Get.lazyPut(() => FetchChapterComicUsecase(Get.find()));
  }
}
