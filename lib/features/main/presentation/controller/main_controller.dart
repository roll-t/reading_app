import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/auth/di/user_binding.dart';
import 'package:reading_app/features/auth/presentation/user/pages/profile_page.dart';
import 'package:reading_app/features/bookcase/di/book_case_binding.dart';
import 'package:reading_app/features/bookcase/presentation/page/book_case_page.dart';
import 'package:reading_app/features/comic/di/comic_binding.dart';
import 'package:reading_app/features/comic/presentation/comic_collection/page/commic_collection_page.dart';
import 'package:reading_app/features/home/di/home_binding.dart';
import 'package:reading_app/features/home/presentation/page/home_page.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  var navbarOpacity = 1.0.obs;

  final List<String> pages = [
    '/home',
    '/comic',
    '/bookCase',
    '/profile',
  ];

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
          page: () => const ComicCollectionPage(),
          binding: ComicBinding(),
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
          binding: UserBinding(),
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
