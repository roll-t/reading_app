import 'package:get/get.dart';
import 'package:reading_app/core/data/domain/user/save_user_use_case.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
  }
}
