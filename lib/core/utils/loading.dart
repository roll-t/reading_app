import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading extends StatelessWidget {
  final RxBool isLoading;
  final Widget bodyBuilder;

  const Loading(
      {super.key, required this.isLoading, required this.bodyBuilder});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? const Center(child: Text("loading"))
          : bodyBuilder;
    });
  }
}
