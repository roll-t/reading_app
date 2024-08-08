import 'package:get/get.dart';
import 'package:reading_app/features/expanded/book/data/book_impl.dart';
import 'package:reading_app/features/expanded/book/data/remote/api/book_remote.dart';
import 'package:reading_app/features/expanded/book/domain/book_repository.dart';
import 'package:reading_app/features/expanded/book/domain/use_case/book_use_case.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/widget_controller.dart';
class BookDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookRemote(Get.find()));
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
    Get.lazyPut(() => BookUseCase(Get.find()));
    Get.put(WidgetController());

    Get.put<BookDetailController>(
      BookDetailController(),
    );
  }
}
