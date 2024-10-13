import 'package:get/get.dart';
import 'package:reading_app/core/data/service/api/comic_api.dart';
import 'package:reading_app/features/expanded/book/domain/use_case/book_use_case.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/widget_controller.dart';

class BookDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComicApi());
    Get.lazyPut(() => BookUseCase(Get.find()));
    Get.put(WidgetController());

    Get.put<BookDetailController>(
      BookDetailController(),
    );
  }
}
