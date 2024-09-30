import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/database/data/model/authentication_model.dart';
import 'package:reading_app/core/database/domain/auth_use_case.dart';
import 'package:reading_app/core/routes/routes.dart';

class LayoutBookDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabController;

  var tabIndex = 0.obs;

  var opacity = 0.0.obs;

  var isLoading = false.obs;

  var isAuth = false.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListening);
    _initial();
    isLoading.value = false;
  }

  _initial() async {
    tabController = TabController(length: 2, vsync: this);
    isAuth.value = await AuthUseCase.isLogin();
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  Future<void> handleLogin() async {
    isLoading.value = true;
    var result = await Get.toNamed(Routes.login);
    if (result != null && result is AuthenticationModel) {
      if (result.authenticated) {
        isAuth.value = result.authenticated;
        isLoading.value = false;
      }
    }
  }

  void _scrollListening() {
    if (!scrollController.hasClients) return;
    double offset = scrollController.offset;
    double threshold = 350.0 / 2;
    if (offset >= threshold) {
      opacity.value = 1.0;
    } else if (offset < threshold && offset > 0) {
      opacity.value = offset / threshold;
    } else {
      opacity.value = 0.0;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListening);
    scrollController.dispose();
    super.onClose();
  }
}
