import 'package:get/get.dart';
import 'package:reading_app/core/service/api/locals/book_case_service.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';

class BookDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComicApi>(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut<BookCaseService>(() => BookCaseService(Get.find(), Get.find()));
  }
}
