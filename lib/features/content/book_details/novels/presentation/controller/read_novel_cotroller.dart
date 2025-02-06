import 'dart:async'; // Import for Timer

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/commentRequest.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/comment_service.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/core/services/api/domain/usecase/themes/read_theme_use_case.dart';
import 'package:reading_app/features/content/book_details/novels/model/novel_argument_model.dart';

class ReadNovelCotroller extends GetxController {
  ChapterNovelModel chapterNovelModel = DefaultData.defaultChapter;

  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];

  ScrollController scrollController = ScrollController();

  var currentActiveList = 0.obs;

  var isControlsVisible = true.obs;

  Timer? _hideControlsTimer;

  var isLoadingProcess = false.obs;

  bool _hasScrolledToBottom = false;

  RxInt themeControlIndex = 1.obs;

  Map<String, dynamic>? currentReadTheme;

  double textSizeReadTheme = 20;

  String fontReadTheme = AppConstants.fontDefault;

  List<String> fonts = AppConstants.listFont;

  dynamic authID;

  CommentService commentData = Get.find();

  RxList<CommentResponse> listComment = <CommentResponse>[].obs;

  final TextEditingController commentController = TextEditingController();

  RxString comment = ''.obs;

  ReadingBookCaseRequest readingBookReturn = ReadingBookCaseRequest(
      bookDataId: "",
      uid: '',
      chapterName: '',
      readingDate: DateTime.now(),
      positionReading: 0);

  @override
  void onInit() async {
    super.onInit();
    _startHideControlsTimer();
    await _intReadTheme();
    scrollController.addListener(_scrollListener);
    initial();
  }

  _intReadTheme() async {
    currentReadTheme =
        await ReadThemeUseCase.getReadTheme() ?? AppConstants.readThemeIds[0];
    textSizeReadTheme = await ReadThemeUseCase.getTextSizeReadTheme();
    fontReadTheme = await ReadThemeUseCase.getFontReadTheme();
    var auth = await AuthUseCase.getAuthToken();
    authID = JwtDecoder.decode(auth)["uid"];
    update(["ControlThemeId"]);
  }

  void initial() {
    if (Get.arguments != null) {
      if (Get.arguments is NovelArgumentModel) {
        var data = Get.arguments as NovelArgumentModel;
        chapterNovelModel = data.chapterCurrent;
        listChapter = data.listChapter;
        readingBookReturn = ReadingBookCaseRequest(
            bookDataId: data.bookId,
            uid: authID ?? "",
            chapterName: chapterNovelModel.chapterName,
            readingDate: DateTime.now(),
            positionReading: scrollController.position.pixels);
      }

      if (Get.arguments is Map<String, dynamic>) {
        if (Get.arguments["listChapter"] != null) {
          listChapter = Get.arguments["listChapter"];
          if (Get.arguments["readContinue"] != null) {
            ReadingBookCaseResponse bookCase =
                Get.arguments["readContinue"] as ReadingBookCaseResponse;
            var chapterCurrent = listChapter.firstWhere(
                (chapter) => chapter.chapterName == bookCase.chapterName);
            chapterNovelModel = chapterCurrent;
            readingBookReturn = ReadingBookCaseRequest(
                bookDataId: bookCase.bookDataId,
                uid: authID ?? "",
                chapterName: chapterNovelModel.chapterName,
                readingDate: DateTime.now(),
                positionReading: scrollController.position.pixels);
            try {
              chapterNovelModel = listChapter.firstWhere(
                  (chapter) => chapter.chapterName == bookCase.chapterName);
              scrollController.animateTo(
                scrollController.position.pixels + bookCase.positionReading,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              );
            } catch (e) {
              print(e);
            }
          }
        }
      }
    }
  }

  Future<void> fetchListComment() async {
    var response = await commentData.fetchAllCommentByChapterId(
        chapterId: chapterNovelModel.chapterId);
    if (response.status == Status.success) {
      listComment.value = response.data ?? [];
    }
  }

  Future<void> addComment({required String contentComment}) async {
    isLoadingProcess.value = true;
    var response = await commentData.addComment(
        request: CommentRequest(
            userId: authID,
            content: contentComment,
            chapterId: chapterNovelModel.chapterId),
        bookId: chapterNovelModel.bookDataId);
    if (response.status == Status.success) {
      listComment.insert(0, response.data!);
      Fluttertoast.showToast(msg: "Đã bình luận");
    }
    isLoadingProcess.value = false;
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

  Future<void> deleteComment(String commentId) async {
    isLoadingProcess.value = true;
    var response = await commentData.deleteReadingComment(commentId: commentId);

    if (response.status == Status.success) {
      listComment.removeWhere((comment) => comment.commentId == commentId);
      Fluttertoast.showToast(msg: "Đã xóa");
    }
    isLoadingProcess.value = false;
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
    chapterNovelModel = selectedChapter;
    readingBookReturn.chapterName = chapterNovelModel.chapterName;
    updateChapter();
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
    readingBookReturn.chapterName = chapterNovelModel.chapterName;
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
    readingBookReturn.chapterName = chapterNovelModel.chapterName;
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
    const double threshold = 50.0;

    if (scrollController.position.pixels <
            scrollController.position.maxScrollExtent - threshold ||
        _hasScrolledToBottom) {
      readingBookReturn.positionReading = scrollController.position.pixels;
      return;
    }

    _hasScrolledToBottom = true;
    onScrolledToBottom();
    readingBookReturn.positionReading = scrollController.position.pixels;
  }

  void onScrolledToBottom() {
    _hasScrolledToBottom = true;
    isControlsVisible.value = true;
    _hasScrolledToBottom = false;
  }
}
