import 'package:get/get.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/get_user_use_case.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/dashboard/profile/presentation/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
