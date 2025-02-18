import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/features/content/searches/data/repositories/search_repository_impl.dart';
import 'package:reading_app/features/content/searches/domain/repositories/search_repository.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_comics_default_search_usecase.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_comics_search_usecase.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_novel_search_usecase.dart';
import 'package:reading_app/features/content/searches/presentation/controller/search_comic_controller.dart';
import 'package:reading_app/features/content/searches/presentation/controller/search_novel_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ComicApi(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => NovelService(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut<SearchRepository>(
      () => SearchRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut<FetchComicsDefaultSearchUsecase>(
      () => FetchComicsDefaultSearchUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut<FetchNovelSearchUsecase>(
      () => FetchNovelSearchUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut<FetchComicsSearchUsecase>(
      () => FetchComicsSearchUsecase(
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => SearchComicController(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SearchNovelController(
        Get.find(),
      ),
    );
  }
}
