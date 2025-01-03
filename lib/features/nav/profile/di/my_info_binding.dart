import 'package:get/get.dart';
import 'package:reading_app/core/storage/use_case/get_user_use_case.dart';
import 'package:reading_app/core/storage/use_case/save_user_use_case.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/my_info_controller.dart';

class MyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => MyInfoController(Get.find(), Get.find()));
  }
}
