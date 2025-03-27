import 'package:get/get.dart';
import 'package:reading_app/core/services/network/api_service.dart';
import 'package:reading_app/core/services/network/dio_service.dart';
import 'package:reading_app/core/storage/cache/cache_service.dart';
import 'package:reading_app/features/auth/domain/usecase/get_auth_token_usecase.dart';
import 'package:reading_app/features/comic/data/repositories/category_repository_impl.dart';
import 'package:reading_app/features/comic/data/sources/category_comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/category_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<CacheService>(
      CacheService(),
    );
    Get.lazyPut(
      () => CategoryComicService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        Get.find(),
      ),
    );
    Get.lazyPut<ApiService>(
      () => ApiService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => GetAuthTokenUseCase(),
    );
    Get.lazyPut<DioConfig>(
      () => DioConfig(
        Get.find(),
      ),
    );
  }
}
