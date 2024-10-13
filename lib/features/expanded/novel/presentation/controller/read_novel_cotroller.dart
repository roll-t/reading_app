import 'dart:async'; // Import for Timer

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/data/database/model/chapter_novel_model.dart';
import 'package:reading_app/core/data/domain/read_theme_use_case.dart';

class ReadNovelCotroller extends GetxController {
  ChapterNovelModel chapterNovelModel = DefaultData.defaultChapter;

  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];

  ScrollController scrollController = ScrollController();

  var currentActiveList = 0.obs;

  var isControlsVisible = true.obs;

  Timer? _hideControlsTimer;

  bool _hasScrolledToBottom = false;

  RxInt themeControlIndex = 1.obs;

  Map<String, dynamic>? currentReadTheme;

  double textSizeReadTheme = 20;

  String fontReadTheme = AppConstants.fontDefault;

  List<String> fonts = AppConstants.listFont;

  @override
  void onInit() {
    super.onInit();
    _startHideControlsTimer();
    _intReadTheme();
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

  _intReadTheme() async {
    currentReadTheme =
        await ReadThemeUseCase.getReadTheme() ?? AppConstants.readThemeIds[0];
    textSizeReadTheme = await ReadThemeUseCase.getTextSizeReadTheme();
    fontReadTheme = await ReadThemeUseCase.getFontReadTheme();
    update(["ControlThemeId"]);
  }

  @override
  void onClose() {
    _hideControlsTimer?.cancel();
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  void _startHideControlsTimer() {
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      isControlsVisible.value = false;
    });
  }

  void toggleControlVisibility() {
    isControlsVisible.value = !isControlsVisible.value;
    if (isControlsVisible.value) {
      _hideControlsTimer?.cancel();
      _hideControlsTimer = Timer(const Duration(seconds: 60), () {
        isControlsVisible.value = false;
      });
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  void changeReadTheme({required Map<String, dynamic> readTheme}) {
    currentReadTheme = readTheme;
    ReadThemeUseCase.setReadTheme(
        readThemSetting: currentReadTheme ?? AppConstants.readThemeIds[0]);
    update(["ListThemeReadID", "ControlThemeId"]);
  }

  void changeFontReadTheme({required String font}) {
    fontReadTheme = font;
    ReadThemeUseCase.setFontReadTheme(font: font);
    update(["mainContentChapter"]);
  }

  void changeTextSizeReadTheme({required double size}) {
    if (size < 13) {
      textSizeReadTheme = 13;
    } else if (size > 40) {
      textSizeReadTheme = 40;
    } else {
      textSizeReadTheme = size;
    }
    ReadThemeUseCase.setTextSizeReadTheme(sizeText: textSizeReadTheme);
    update(["mainContentChapter"]);
  }

  void clickControl() {
    isControlsVisible.value = true;
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 10), () {
      isControlsVisible.value = false;
    });
  }

  void changChapter({required String chapterId}) {
    ChapterNovelModel? selectedChapter = listChapter.firstWhere(
      (chapter) => chapter.chapterId == chapterId,
    );
    if (selectedChapter != null) {
      chapterNovelModel = selectedChapter;
      updateChapter();
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
      scrollController.position.pixels + 230,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  //Scroll Top
  void scrollTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 50 &&
        !_hasScrolledToBottom) {
      onScrolledToBottom();
    }
  }

  void onScrolledToBottom() {
    _hasScrolledToBottom = true;
    isControlsVisible.value = true;
    _hasScrolledToBottom = false;
  }
}
