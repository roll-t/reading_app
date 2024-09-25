import 'package:get/get.dart';
import 'package:reading_app/core/services/domain/user/get_user_use_case.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/features/splash/presentation/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => SplashController());
  }
}
