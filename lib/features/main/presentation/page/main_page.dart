import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';
import 'package:reading_app/features/main/presentation/widgets/custom_navigation_bar.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(10),
        initialRoute: "/home",
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => CustomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.onChangeItemBottomBar(index);
          },
        ),
      ),
    );
  }
}
