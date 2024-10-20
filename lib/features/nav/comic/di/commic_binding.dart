import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/nav/comic/presentation/controller/commic_controller.dart';

class CommicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => CommicController());
  }
}
