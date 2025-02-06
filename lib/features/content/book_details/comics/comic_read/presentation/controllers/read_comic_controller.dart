import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_comic%20_model.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/features/content/book_details/comics/comic_detail/data/model/argument_comic_chapter_model.dart';
import 'package:reading_app/features/content/book_details/comics/comic_read/domain/usecase/fetch_chapter_comic_usecase.dart';

class ReadComicController extends GetxController {
  
  final FetchChapterComicUsecase _chapterComicUsecase;

  ReadComicController(this._chapterComicUsecase);

  ChapterComicModel? chapterModel;

  List<dynamic> listChapterImage = [];

  var imageUrls = <String>[].obs;

  var loading = false.obs;

  var page = 0.obs;

  final int pageSize = 5;

  final ScrollController scrollController = ScrollController();

  double positionReading = 0;

  Timer? _hideControlsTimer;

  bool _hasScrolledToBottom = false;

  RxMap<String, dynamic> currentChapterArguments = <String, dynamic>{}.obs;

  var isControlsVisible = true.obs;

  List<dynamic> listChapterArgument = [];

  bool maxLengthImagechapter = false;

  double currentPosition = 0;

  ComicApi comicApi = Get.find();

  @override
  void onInit() async {
    super.onInit();
    initial();
    scrollController.addListener(_scrollListener);
    loading.value = true;
    await fetchBookImages();
    loading.value = false;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreImages();
      }
    });
  }

  void initial() {
    if (Get.arguments != null) {
      if (Get.arguments is ArgumentComicChapterModel) {
        var data = Get.arguments as ArgumentComicChapterModel;
        currentChapterArguments.value = data.currentChapter;
        listChapterArgument = data.listChapter;
        positionReading = data.positionReading ?? 0;
      }
    }
  }

  Future<void> fetchBookImages() async {
    imageUrls.clear();
    // ignore: invalid_use_of_protected_member
    final result = await _chapterComicUsecase(currentChapterArguments.value);
    if (result != null) {
      chapterModel = result;
      page.value = 0;
      await loadMoreImages();
    }
  }

  Future<void> loadMoreImages() async {
    loading.value = true;
    if (chapterModel == null) return;
    int startIndex = page.value * pageSize;
    int endIndex = (page.value + 1) * pageSize;
    endIndex = endIndex > chapterModel!.chapterImages.length - 1
        ? chapterModel!.chapterImages.length
        : endIndex;
    List<String> newImages = [];
    for (int i = startIndex; i < endIndex; i++) {
      var urlResult =
          "${chapterModel!.domain}/${chapterModel!.chapterPath}/${chapterModel!.chapterImages[i].imageFile}";
      newImages.add(urlResult);
    }

    imageUrls.addAll(newImages);

    if (imageUrls.length >= chapterModel!.chapterImages.length) {
      maxLengthImagechapter = true;
    }
    page.value++;
    loading.value = false;
    if (positionReading != 0) {
      await Future.delayed(const Duration(milliseconds: 100));
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      if (scrollController.position.pixels < positionReading) {
        loadMoreImages();
      } else {
        await scrollController.animateTo(
          positionReading,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Scroll up
  void scrollUp() {
    scrollController.animateTo(
      scrollController.position.pixels - 230,
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

  int currentIndexChapter({required String chapterId}) {
    int index = listChapterArgument.indexWhere(
      (chapter) => chapter["chapter_name"] == chapterId,
    );
    return index;
  }

  void changChapter({required String chapterId}) {
    positionReading = 0;
    var selectedChapter = listChapterArgument.firstWhere(
      (chapter) => chapter["chapter_name"] == chapterId,
    );
    if (selectedChapter != null) {
      currentChapterArguments.value = selectedChapter;
      updateChapter();
      update(["listSelected"]);
    }
  }

  void nextChapter({required String chapterId}) {
    loading.value = true;
    currentPosition = 0;
    int currentIndex = currentIndexChapter(chapterId: chapterId);
    if (currentIndex + 1 > listChapterArgument.length - 1) {
      Fluttertoast.showToast(msg: "Đây là chapter cuối cùng");
      loading.value = false;
      return;
    }

    currentChapterArguments.value = listChapterArgument[currentIndex + 1];
    updateChapter();
    Fluttertoast.showToast(
        // ignore: invalid_use_of_protected_member
        msg: "Chương ${currentChapterArguments.value["chapter_name"]}");
    loading.value = false;
  }

  void preChapter({required String chapterId}) {
    loading.value = true;
    currentPosition = 0;
    int currentIndex = currentIndexChapter(chapterId: chapterId);
    if (currentIndex == 0) {
      Fluttertoast.showToast(msg: "Đây là chapter đầu tiên");
      loading.value = false;
      return;
    }

    currentChapterArguments.value = listChapterArgument[currentIndex - 1];
    updateChapter();
    Fluttertoast.showToast(
        // ignore: invalid_use_of_protected_member
        msg: "Chương ${currentChapterArguments.value["chapter_name"]}");
    loading.value = false;
  }

  void updateChapter() {
    positionReading = 0;
    scrollTop();
    fetchBookImages();
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

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 50 &&
        !_hasScrolledToBottom) {
      onScrolledToBottom();
    }
  }

  void onScrolledToBottom() {
    _hasScrolledToBottom = true;
    if (maxLengthImagechapter) {
      isControlsVisible.value = true;
    }
    _hasScrolledToBottom = false;
  }
}
