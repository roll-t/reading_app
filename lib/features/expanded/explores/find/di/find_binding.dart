

import 'package:get/get.dart';
import 'package:reading_app/features/expanded/explores/find/presentation/controller/find_controller.dart';

class FindBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(FindController());
  }

}