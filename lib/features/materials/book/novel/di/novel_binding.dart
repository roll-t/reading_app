

import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/layout_book_detail/presentation/controller/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/book/novel/presentation/controller/novel_detail_controller.dart';

class NovelBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>NovelDetailController());
    Get.lazyPut(()=>LayoutBookDetailController());
  }
}