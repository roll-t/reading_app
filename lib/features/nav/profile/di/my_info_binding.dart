import 'package:get/get.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/get_user_use_case.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/save_user_use_case.dart';
import 'package:reading_app/core/services/utils/images_service.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/my_info_controller.dart';

class MyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => MyInfoController(Get.find(), Get.find()));
    Get.lazyPut(() => ImagesService(Get.find(), Get.find()));
  }
}
