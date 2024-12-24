import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/features/splash/presentation/controller/splash_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(width: 40.w, AppImages.iLoading)),
    );
  }
}
