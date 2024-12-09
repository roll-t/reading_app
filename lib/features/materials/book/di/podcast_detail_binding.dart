import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/domain/use_case/book_use_case.dart';
import 'package:reading_app/features/materials/book/presentation/controller/podcast_detail_controller.dart';
class PodcastDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookUseCase(Get.find()));
    Get.put<PodcastDetailController>(
      PodcastDetailController(),
    );
  }
}
