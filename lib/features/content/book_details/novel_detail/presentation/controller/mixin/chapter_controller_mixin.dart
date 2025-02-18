import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/utils/scroll_utils.dart';

mixin ChapterControllerMixin on GetxController {
  RxBool isLoadingChapter = false.obs;

  RxBool isOverlayLayerVisible = false.obs;

  final ScrollController scrollController = ScrollController();

  final Map<int, double> chapterPositions = {};

  Rx<ChapterNovelModel> chaptersDisplay = ChapterNovelModel().obs;

  List<ChapterNovelModel> listChapter = [];

  int currentChapterIndex = 0;

  Timer? _debounce;

  bool isLastChapter = true;

  void initScrollControllerMixin() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.atEdge &&
        ScrollUtils.isMaxScrollExtent(scrollController)) {
      loadNextChapter();
    }
  }

  void changeChapter(ChapterNovelModel currentChapter, int index) {
    chaptersDisplay.value = currentChapter;
    currentChapterIndex = index;
    _animateScrollToTop();
  }

  void loadNextChapter() {
    _loadChapter(isNext: true);
  }

  void loadPreviousChapter() {
    _loadChapter(isNext: false);
  }

  void _loadChapter({bool isNext = true}) {
    if (!isNext) {
      if (currentChapterIndex > 0) {
        currentChapterIndex--;
      } else {
        Fluttertoast.showToast(msg: 'Đang ở chapter đầu tiên');
        isLastChapter = true;
        return;
      }
    } else {
      if (currentChapterIndex < listChapter.length - 1) {
        currentChapterIndex++;
      } else {
        Fluttertoast.showToast(msg: 'Đây là chapter mới nhất');
        isLastChapter = true;
        return;
      }
    }

    chaptersDisplay.value = listChapter[currentChapterIndex];
    _animateScrollToTop();
  }

  void _animateScrollToTop() {
    isLoadingChapter.value = true;
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        if (scrollController.hasClients) {
          scrollController
              .animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
              .then((_) {
            isLoadingChapter.value = false;
          });
        } else {
          isLoadingChapter.value = false;
        }
      },
    );
  }

  void tapToAutoScroll(TapUpDetails details, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final tapPosition = details.globalPosition.dy;
    isOverlayLayerVisible.value = true;
    if (tapPosition < screenHeight / 2) {
      scrollController.animateTo(
          (scrollController.offset - 250)
              .clamp(0.0, scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut);
    } else {
      scrollController.animateTo(
          (scrollController.offset + 250)
              .clamp(0.0, scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut);
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    scrollController.dispose();
    super.onClose();
  }
}
