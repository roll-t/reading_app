import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/repositories/category_repository_impl.dart';
import 'package:reading_app/core/services/api/data/repositories/user_repository_impl.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/user_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/category_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/category_repository.dart';
import 'package:reading_app/core/services/api/domain/repositories/user_repository.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/backup/get_user_usecase.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/dashboard/home/data/reposirories/home_repository_impl.dart';
import 'package:reading_app/features/dashboard/home/domain/repositories/home_repository.dart';
import 'package:reading_app/features/dashboard/home/domain/usecase/fetch_auth_usecase.dart';
import 'package:reading_app/features/dashboard/home/domain/usecase/fetch_novels_usecase.dart';
import 'package:reading_app/features/dashboard/home/domain/usecase/fetch_slider_usecase.dart';
import 'package:reading_app/features/dashboard/home/domain/usecase/fetch_up_coming_comics_usecase.dart';
import 'package:reading_app/features/dashboard/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //Storage
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut<UserRepository>(
        () => UserRepositoryImpl(Get.find(), Get.find()),
        fenix: true);

    Get.lazyPut(() => CheckCategoryCacheUsecase(Get.find()));

    Get.lazyPut(() => CategoryService(Get.find(), Get.find()), fenix: true);

    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()),
        fenix: true);

    Get.lazyPut<HomeRepository>(
        () => HomeRepositoryImpl(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<UserService>(() => UserService(Get.find(), Get.find()),
        fenix: true);

    //API
    Get.lazyPut<ComicApi>(() => ComicApi(Get.find(), Get.find()));
    Get.lazyPut<NovelService>(() => NovelService(Get.find(), Get.find()));

    //Controller
    Get.lazyPut<HomeController>(() => HomeController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));

    //Usecase
    Get.lazyPut(() => GetUserUsecase(Get.find()));
    Get.lazyPut(() => FetchAuthUsecase(Get.find()));
    Get.lazyPut(() => FetchSliderUsecase(Get.find()));
    Get.lazyPut(() => FetchCategoriesCacheUsecase(Get.find()));
    Get.lazyPut(() => FetchUpComingComicsUsecase(Get.find()));
    Get.lazyPut(() => FetchNovelsUsecase(Get.find()));
  }
}
