

import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/novel/presentation/controller/novel_detail_controller.dart';

class NovelBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>NovelDetailController());
    Get.lazyPut(()=>LayoutBookDetailController());
  }
}