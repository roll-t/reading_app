import 'package:get/get.dart';
import 'package:reading_app/core/service/api/locals/book_case_service.dart';
import 'package:reading_app/core/service/storage/prefs/prefs.dart';
import 'package:reading_app/features/nav/book_case/presentation/controller/book_case_controller.dart';

class BookCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<BookCaseService>(() => BookCaseService(Get.find(), Get.find()));
    Get.lazyPut(() => BookCaseController());
  }
}
