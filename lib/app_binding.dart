import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/repositories/category_repository_impl.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/category_comic_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/category_repository.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/get_auth_token_usecase.dart';
import 'package:reading_app/core/services/network/api_service.dart';
import 'package:reading_app/core/services/network/dio_service.dart';
import 'package:reading_app/core/storage/cache/cache_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<CacheService>(CacheService());
    Get.lazyPut(() => CategoryComicService(Get.find(), Get.find()));
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()));
    Get.lazyPut<ApiService>(() => ApiService(Get.find(), Get.find()));
    Get.lazyPut(() => GetAuthTokenUseCase());
    Get.lazyPut<DioConfig>(() => DioConfig(Get.find()));
  }
}
