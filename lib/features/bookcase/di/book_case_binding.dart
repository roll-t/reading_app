import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/sources/locals/book_case_service.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/bookcase/data/repositories/book_case_repository_impl.dart';
import 'package:reading_app/features/bookcase/domain/repositories/book_case_repository.dart';
import 'package:reading_app/features/bookcase/domain/usecase/fetch_novels_bookcase_usecase.dart';
import 'package:reading_app/features/bookcase/domain/usecase/fetch_novels_favorite_bookcase_usecase.dart';
import 'package:reading_app/features/bookcase/domain/usecase/remove_novel_favorite_usecase.dart';
import 'package:reading_app/features/bookcase/presentation/controller/book_case_controller.dart';

class BookCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut<BookCaseService>(
      () => BookCaseService(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut<BookCaseRepository>(
      () => BookCaseRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => BookCaseController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => FetchNovelsBookcaseUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => FetchNovelsFavoriteBookcaseUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => RemoveNovelFavoriteUsecase(
        Get.find(),
      ),
    );
  }
}
