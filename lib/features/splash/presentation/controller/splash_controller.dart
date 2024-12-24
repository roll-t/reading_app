import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/storage/cache/cache_manager.dart';
import 'package:reading_app/core/storage/use_case/auth_use_case.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkCacheExpiration();
    checkCacheSize();
  }

  Future<void> checkCacheExpiration() async {
    try {
      if (await CacheManager.isCacheExpired()) {
        // await CacheManager.deleteCache();
        await CacheManager.saveCacheTime();
      } else {}
      navigateToNextScreen();
    } catch (e) {
      print("Error during cache expiration check: $e");
    }
  }

  Future<void> navigateToNextScreen() async {
    if (await AuthUseCase.isLogin()) {
      Get.offAndToNamed(Routes.main);
    } else {
      Get.offNamed(Routes.login);
    }
  }

  Future<void> checkCacheSize() async {
    try {
      int size = await CacheManager.getCacheSize();
      print('Cache size: ${size / (1024 * 1024)} MB');
    } catch (e) {
      print("Error calculating cache size: $e");
    }
  }
}
