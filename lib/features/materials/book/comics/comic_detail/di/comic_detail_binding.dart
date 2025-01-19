import 'package:get/get.dart';
import 'package:reading_app/core/service/api/locals/comment_comic_service.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';
import 'package:reading_app/features/materials/book/comic/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/book/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';

class ComicDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LayoutBookDetailController());
    Get.lazyPut(() => ComicDetailController(Get.find()));
    Get.lazyPut(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut<CommentComicService>(
        () => CommentComicService(Get.find(), Get.find()));
  }
}
