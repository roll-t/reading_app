

import 'package:get/get.dart';
import 'package:reading_app/features/content/searches/presentation/controller/search_controller.dart';

class FindBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(FindController());
  }

}