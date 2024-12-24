import 'package:get/get.dart';
import 'package:reading_app/core/service/data/api/remote/comic_service.dart';
import 'package:reading_app/features/materials/book/presentation/controller/book_detail_controller.dart';

class BookDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComicApi());

    Get.put<BookDetailController>(
      BookDetailController(),
    );
  }
}
