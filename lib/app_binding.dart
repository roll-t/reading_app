import 'package:get/get.dart';
import 'package:reading_app/core/services/configs/dio_config.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(()=>DioConfig());
  }
}
