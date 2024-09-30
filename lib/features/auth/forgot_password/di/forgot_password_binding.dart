import 'package:get/get.dart';
import 'package:reading_app/core/database/domain/user/save_user_use_case.dart';
import 'package:reading_app/core/database/prefs/prefs.dart';
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
  }
}
