import 'package:get/get.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.put(HomeController());
  }
}
