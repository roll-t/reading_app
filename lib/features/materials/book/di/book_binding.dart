import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/domain/use_case/book_use_case.dart';
import 'package:reading_app/features/materials/book/presentation/controller/book_controller.dart';
class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookUseCase(Get.find()));

    Get.put<BookController>(
      BookController(),
    );
  }
}
