import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/content/book_details/novels/presentation/controller/read_novel_cotroller.dart';

class ReadNovelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(()=>ReadNovelCotroller());
  }
}
