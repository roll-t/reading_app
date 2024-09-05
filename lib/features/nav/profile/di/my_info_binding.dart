

import 'package:get/get.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/my_info_controller.dart';

class MyInfoBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MyInfoController());
  }

}