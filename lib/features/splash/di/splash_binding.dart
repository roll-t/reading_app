import 'package:get/get.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reading_app/features/auth/data/sources/auth_service.dart';
import 'package:reading_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:reading_app/features/auth/domain/usecase/user/get_user_use_case.dart';
import 'package:reading_app/features/auth/domain/usecase/login/is_login_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/category/check_category_cache_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/category/set_categories_cache_usecase.dart';
import 'package:reading_app/features/splash/presentation/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => AuthService(Get.find(), Get.find()));
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => IsLoginUseCase(Get.find()));
    Get.lazyPut(() => SetCategoriesCacheUsecase(Get.find()));
    Get.lazyPut(() => CheckCategoryCacheUsecase(Get.find()));

    Get.put(SplashController(Get.find(), Get.find()));
  }
}
