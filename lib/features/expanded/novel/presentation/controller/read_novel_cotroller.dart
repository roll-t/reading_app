import 'dart:async'; // Import for Timer

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/database/data/model/chapter_novel_model.dart';

class ReadNovelCotroller extends GetxController {
  ChapterNovelModel chapterNovelModel = DefaultData.defaultChapter;
  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];
  ScrollController scrollController = ScrollController();
  var currentActiveList = 0.obs;

  var isControlsVisible = true.obs;

  Timer? _hideControlsTimer;

  bool _hasScrolledToBottom = false;

  @override
  void onInit() {
    super.onInit();
    // Show controls for 2 seconds when the page is first loaded
    _startHideControlsTimer();

    // Add a listener to the scroll controller
    scrollController.addListener(_scrollListener);

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments['chapterCurrent'] is ChapterNovelModel) {
        chapterNovelModel = Get.arguments['chapterCurrent'];
      }
      if (Get.arguments['listChapter'] is List<ChapterNovelModel>) {
        listChapter = Get.arguments['listChapter'];
      }
    }
  }

  @override
  void onClose() {
    _hideControlsTimer?.cancel(); 
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  void _startHideControlsTimer() {
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      isControlsVisible.value = false; // Hide controls after 2 seconds
    });
  }

  void toggleControlVisibility() {
    isControlsVisible.value = !isControlsVisible.value; // Toggle visibility
    // Restart timer to hide controls after 2 seconds if they are shown
    if (isControlsVisible.value) {
      _hideControlsTimer?.cancel(); // Cancel existing timer
      _hideControlsTimer = Timer(const Duration(seconds: 1000), () {
        isControlsVisible.value = false; // Hide controls after 2 seconds
      });
    } else {
      // If controls are being hidden, cancel the timer
      _hideControlsTimer?.cancel();
    }
  }

  void clickControl() {
    // Called when a control is clicked
    isControlsVisible.value = true; // Ensure controls remain visible
    _hideControlsTimer?.cancel(); // Cancel the timer if visible
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      isControlsVisible.value = false; // Hide controls after 2 seconds
    });
  }

  void changChapter({required String chapterId}) {
    ChapterNovelModel? selectedChapter = listChapter.firstWhere(
      (chapter) => chapter.chapterId == chapterId, // Condition to find chapter
    );
    if (selectedChapter != null) {
      chapterNovelModel = selectedChapter;
      updateChapter();
    } else {
      print("Chapter not found with id: $chapterId");
    }
  }

  void updateChapter() {
    scrollTop();
    update(["listSelected", "mainContentChapter"]);
  }

  int currentIndexChapter({required String chapterId}) {
    int index = listChapter.indexWhere(
      (chapter) => chapter.chapterId == chapterId,
    );
    return index;
  }

  void nextChapter({required chapterId}) {
    int currentIndex = currentIndexChapter(chapterId: chapterId);
    if (currentIndex + 1 > listChapter.length - 1) {
      Fluttertoast.showToast(msg: "Đây là chapter mới nhất");
      return;
    }
    chapterNovelModel = listChapter[currentIndex + 1];
    scrollTop();
    Fluttertoast.showToast(msg: chapterNovelModel.chapterName);
    updateChapter();
  }

  void preChapter({required chapterId}) {
    int currentIndex = currentIndexChapter(chapterId: chapterId);
    if (currentIndex == 0) {
      Fluttertoast.showToast(msg: "Đây là chapter đầu tiên");
      return;
    }
    chapterNovelModel = listChapter[currentIndex - 1];
    scrollTop();
    Fluttertoast.showToast(msg: chapterNovelModel.chapterName);
    updateChapter();
  }

  // Scroll up
  void scrollUp() {
    scrollController.animateTo(
      scrollController.position.pixels - 230, // Scroll up 230 pixels
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  // Scroll down
  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.pixels + 230, // Scroll down 230 pixels
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void scrollTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void _scrollListener() {
    // Check if scrolled close enough to the bottom
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 50 &&
        !_hasScrolledToBottom) {
      onScrolledToBottom();
    }
  }

  void onScrolledToBottom() {
    _hasScrolledToBottom = true;
    nextChapter(chapterId: chapterNovelModel.chapterId);
    _hasScrolledToBottom=false;
  }

}
