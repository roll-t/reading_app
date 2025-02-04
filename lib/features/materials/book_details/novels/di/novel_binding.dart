import 'package:get/get.dart';
import 'package:reading_app/core/service/api/locals/book_case_service.dart';
import 'package:reading_app/core/service/api/locals/category_service.dart';
import 'package:reading_app/core/service/api/locals/chapter_service.dart';
import 'package:reading_app/core/service/api/locals/comment_service.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/book_details/novels/presentation/controller/novel_detail_controller.dart';

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
