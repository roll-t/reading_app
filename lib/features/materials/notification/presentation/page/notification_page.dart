import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/materials/notification/presentation/controller/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: TextMediumSemiBold(
          textChild: TextFormat.capitalizeEachWord(AppContents.notification),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              controller.clearNotifications();  // Xóa tất cả thông báo khi nhấn nút clear
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.notifications.isEmpty
            ? const Center(
                child: TextNormal(
                  textChild: "Không có thông báo nào",
                ),
              )
            : ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.notifications[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.removeNotification(index);  // Xóa thông báo khi nhấn nút xóa
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNotification('Thông báo mới lúc ${DateTime.now()}');  // Thêm thông báo mới
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
