import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/splash/presentation/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 80.0),
          height: 6.0,
          child: LinearProgressIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.gray3,
            borderRadius: BorderRadius.circular(10.0),
            // You can customize the appearance of the progress indicator
          ),
        ),
      ),
    );
  }
}
