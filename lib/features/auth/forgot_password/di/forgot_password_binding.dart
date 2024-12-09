import 'package:get/get.dart';
import 'package:reading_app/core/service/prefs/prefs.dart';
import 'package:reading_app/core/storage/use_case/save_user_use_case.dart';
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
  }
}
