

import 'package:get/get.dart';
import 'package:reading_app/features/content/notification/presentation/controller/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}