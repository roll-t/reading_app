import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/book_case/di/book_case_binding.dart';
import 'package:reading_app/features/nav/book_case/presentation/page/book_case_page.dart';
import 'package:reading_app/features/nav/comic/di/commic_binding.dart';
import 'package:reading_app/features/nav/comic/presentation/page/commic_page.dart';
import 'package:reading_app/features/nav/home/di/home_binding.dart';
import 'package:reading_app/features/nav/home/presentation/page/home_page.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  var navbarOpacity = 1.0.obs;

  final List<String> pages = ['/home', '/comic', '/bookCase', '/profile'];

  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return GetPageRoute(
          settings: settings,
          page: () => const HomePage(),
          binding: HomeBinding(),
          transition: Transition.fadeIn,
        );
      case '/comic':
        return GetPageRoute(
          settings: settings,
          page: () => const CommicPage(),
          binding: CommicBinding(),
          transition: Transition.fadeIn,
        );
      case '/bookCase':
        return GetPageRoute(
          settings: settings,
          page: () => const BookCasePage(),
          binding: BookCaseBinding(),
          transition: Transition.fadeIn,
        );
      case '/profile':
        return GetPageRoute(
          settings: settings,
          page: () => const ProfilePage(),
          binding: ProfileBinding(),
          transition: Transition.fadeIn,
        );
    }
    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    Get.offAndToNamed(pages[index], id: 10);
  }
}
