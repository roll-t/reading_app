import 'package:get/get.dart';
import 'package:reading_app/core/data/domain/user/remember_user_case.dart';
import 'package:reading_app/core/data/domain/user/save_user_use_case.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';

class LoginBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
    Get.lazyPut(() => RememberUserCase(Get.find()));
    Get.put(LogInController(Get.find(),Get.find()));
  }
}
