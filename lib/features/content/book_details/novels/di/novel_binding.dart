import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/sources/locals/book_case_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/category_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/chapter_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/comment_service.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/features/content/book_details/novels/presentation/controller/novel_detail_controller.dart';

class NovelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NovelDetailController());
    Get.lazyPut(() => CommentService(Get.find(), Get.find()));
    Get.lazyPut(() => CategoryService(Get.find(), Get.find()));
    Get.lazyPut(() => BookCaseService(Get.find(), Get.find()));
    Get.lazyPut(() => ChapterService(Get.find(), Get.find()));
    Get.lazyPut(() => LayoutBookDetailController());
  }
}
