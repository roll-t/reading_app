import 'package:get/get.dart';
import 'package:reading_app/core/database/prefs/prefs.dart';
import 'package:reading_app/features/nav/book_case/presentation/controller/book_case_controller.dart';

class BookCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.put(BookCaseController());
  }
}
