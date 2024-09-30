import 'package:get/get.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/read_novel_cotroller.dart';

class ReadNovelBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ReadNovelCotroller());
  }

}