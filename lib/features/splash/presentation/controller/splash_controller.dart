import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';

class SplashController extends GetxController {
  SplashController();

  RxDouble loadingProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    simulateLoading();
  }

  void simulateLoading() {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (loadingProgress.value >= 1.0) {
        timer.cancel();
        Get.offNamed(Routes.main); // Navigate to main screen when loading is complete
      } else {
        loadingProgress.value += 0.1; // Increment progress by 10%
      }
    });
  }
}
