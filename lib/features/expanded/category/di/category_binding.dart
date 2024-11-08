
import 'package:get/get.dart';
import 'package:reading_app/features/expanded/category/presentation/controller/category_controller.dart';
import 'package:reading_app/features/expanded/category/presentation/controller/category_novel_controller.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CategoryController());
    Get.lazyPut(()=>CategoryNovelController());
  }

}