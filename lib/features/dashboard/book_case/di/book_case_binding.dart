import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/sources/locals/book_case_service.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/controller/book_case_controller.dart';

class BookCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<BookCaseService>(() => BookCaseService(Get.find(), Get.find()));
    Get.lazyPut(() => BookCaseController());
  }
}
