import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookReadController extends GetxController {
  var currentPage = 0.obs;
  var pageOffset = 0.0.obs;
  List<String> imageUrls = [
    "https://i.pinimg.com/736x/fd/0b/69/fd0b699a3dc5e888ef3726b0d10d4c37.jpg",
    "https://file.vfo.vn/hinh/2018/05/top-nhung-hinh-quynh-aka-dep-nhat-de-thuong-hai-huoc-de-chem-gio-1.jpg",
    "https://i.pinimg.com/474x/0b/ee/be/0beebe5dd21273e01cec42bfe4e1b935.jpg",
    "https://i.pinimg.com/736x/50/1f/e4/501fe4a8f2e0290af51738c0c5b6b174.jpg",
    "https://i.pinimg.com/736x/2f/ef/03/2fef03d7ad21e880f0380e551600dbb4.jpg",
    "https://i.pinimg.com/originals/54/c7/13/54c713a6d31ed7fee4b7c7c4c5a9266d.png",
    "https://i.pinimg.com/originals/91/02/75/9102752592c03a2375324f69a120318c.jpg"
  ];
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
