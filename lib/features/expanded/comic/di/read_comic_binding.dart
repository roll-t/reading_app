import 'package:get/get.dart';
import 'package:reading_app/features/expanded/comic/presentation/controllers/read_comic_controller.dart';

class ReadComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadComicController());
  }
}
