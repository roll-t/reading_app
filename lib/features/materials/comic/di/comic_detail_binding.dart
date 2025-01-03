import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/comic/presentation/controllers/comic_detail_controller.dart';

class ComicDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LayoutBookDetailController());
    Get.lazyPut(() => ComicDetailController());
  }
}
