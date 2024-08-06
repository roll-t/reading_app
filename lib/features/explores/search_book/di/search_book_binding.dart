


import 'package:get/get.dart';
import 'package:reading_app/features/explores/search_book/presentation/controller/search_book_controller.dart';

class SearchBookBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchBookController());
  }

}