import 'package:get/get.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/features/nav/commic/presentation/controller/commic_controller.dart';

class CommicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => CommicController());
  }
}
