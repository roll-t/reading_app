import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookReadController extends GetxController {
  var currentPage = 0.obs;
  var pageOffset = 0.0.obs;
  List<String> imageUrls = [];
  final PageController pageController = PageController();
  @override
  void onInit() {
    if (Get.arguments is List<String>) {
      imageUrls = Get.arguments;
    }
    pageController.addListener(() {
      int nextPage = pageController.page!.round();
      double offset = pageController.page!;
      if (currentPage.value != nextPage) {
        updatePage(nextPage);
      }
      updatePageOffset(offset);
    });
  }

  @override
  void onClose() {}
  void updatePage(int page) {
    currentPage.value = page;
  }

  void updatePageOffset(double offset) {
    pageOffset.value = offset;
  }
}
