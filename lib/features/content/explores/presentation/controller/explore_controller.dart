import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/content/explores/presentation/page/explore_comic_type_page.dart';
import 'package:reading_app/features/content/explores/presentation/page/explore_novel_type_page.dart';

class ExploreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  RxBool isDataLoading = false.obs;

  RxBool isLoadMore = false.obs;

  late TabController tabController;

  var currentTypePage = 0.obs;

  var currentIndexCategory = 0.obs;

  var currentCategoryModal = 0.obs;

  RxList<Widget> listPage = [
    const ExploreComicTypePage(),
    const ExploreNovelTypePage(),
  ].obs;

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleChangeTab);
  }

  void _handleChangeTab() {
    if (!tabController.indexIsChanging) {
      currentTypePage.value = tabController.index;
    }
  }
}
