import 'package:get/get.dart';
import 'package:reading_app/core/services/utils/images_service.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/auth/domain/usecase/get_user_use_case.dart';
import 'package:reading_app/features/auth/domain/usecase/save_user_use_case.dart';
import 'package:reading_app/features/auth/presentation/user/controllers/profile_controller.dart';
import 'package:reading_app/features/auth/presentation/user/controllers/profile_detail_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => Prefs(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetuserUseCase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ProfileController(
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => SaveUserUseCase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => GetuserUseCase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ProfileDetailController(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => ImagesService(
        Get.find(),
        Get.find(),
      ),
    );
  }
}
