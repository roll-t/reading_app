import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loading extends StatelessWidget {
  final RxBool isLoading;
  final Widget bodyBuilder;

  const Loading(
      {super.key, required this.isLoading, required this.bodyBuilder});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? Center(child: Image.asset(width: 50.w,AppImages.iLoading))
          : bodyBuilder;
    });
  }
}
