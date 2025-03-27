import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/comic/presentation/comic_explore/page/explore_comic_type_page.dart';
import 'package:reading_app/features/comic/presentation/comic_explore/page/explore_novel_type_page.dart';

///**********************************/
/// CREATE TIME - 18/03/2025
///
/// **USED IN:**
/// - `ExploreComicTypePage`
/// - `ExploreNovelTypePage`
///
/// **EXPLANATION:**
/// This class is used to manage state and control layout logic.
///*********************************/

class ExploreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //---> define Rx variable
  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxInt currentTypePage = 0.obs;
  RxInt currentIndexCategory = 0.obs;
  RxInt currentCategoryModal = 0.obs;

  //---> Define tabbar
  late TabController tabController;

  //---> Define list page display in tabbar
  RxList<Widget> listPage = [
    const ExploreComicTypePage(),
    const ExploreNovelTypePage(),
  ].obs;

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(
      _handleChangeTab,
    );
  }

  //---> Handle event change tabbar
  void _handleChangeTab() {
    if (!tabController.indexIsChanging) {
      currentTypePage.value = tabController.index;
    }
  }
}
