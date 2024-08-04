import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/main/presentation/widgets/custom_navbar.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Navigator(
            key: Get.nestedKey(10),
            initialRoute: "/home",
            onGenerateRoute: controller.onGenerateRoute,
          ),
          const CustomNavbar(),
        ],
      ),
    );
  }
}
