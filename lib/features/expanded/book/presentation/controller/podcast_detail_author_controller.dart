import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PodcastDetailAuthorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
