import 'package:get/get.dart';
import 'package:reading_app/features/expanded/book/data/book_impl.dart';
import 'package:reading_app/features/expanded/book/data/remote/api/book_remote.dart';
import 'package:reading_app/features/expanded/book/domain/book_repository.dart';
import 'package:reading_app/features/expanded/book/domain/use_case/book_use_case.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/podcast_detail_author_controller.dart';
class PodcastDetailAuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookRemote(Get.find()));
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
    Get.lazyPut(() => BookUseCase(Get.find()));

    Get.put<PodcastDetailAuthorController>(
      PodcastDetailAuthorController(),
    );
  }
}
