import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/layout_book_detail/presentation/controller/book_read_controller.dart';
class BookReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookReadController>(BookReadController(),);
  }
}
