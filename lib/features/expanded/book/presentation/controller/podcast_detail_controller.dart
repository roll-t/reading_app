import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PodcastDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late TabController tabController;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    scrollController.addListener(_scrollListening);
  }

  void _scrollListening() {
    if (!scrollController.hasClients) return;
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // limit += _limitIncrement;
      // currentPage++;
      print("scroll");
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
