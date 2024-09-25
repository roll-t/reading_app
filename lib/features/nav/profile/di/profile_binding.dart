import 'package:get/get.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.put(ProfileController());
  }
}
