import 'package:get/get.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/api/configs/dio_config.dart';
import 'package:reading_app/core/service/api/remotes/category_service.dart';
import 'package:reading_app/core/service/data/repositories/category_repository_impl.dart';
import 'package:reading_app/core/service/domain/repositories/category_repository.dart';
import 'package:reading_app/core/service/domain/usecase/auths/get_auth_token_usecase.dart';
import 'package:reading_app/core/service/storage/cache/cache_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<CacheService>(CacheService());
    Get.lazyPut(() => CategoryService(Get.find(), Get.find()));
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()));
    Get.lazyPut<ApiService>(() => ApiService(Get.find(), Get.find()));
    Get.lazyPut(() => GetAuthTokenUseCase());
    Get.lazyPut<DioConfig>(() => DioConfig(Get.find()));
  }
}
