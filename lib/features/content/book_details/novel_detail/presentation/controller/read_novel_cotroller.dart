import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/reading_book_case_request.dart';
import 'package:reading_app/features/content/book_details/novel_detail/model/novel_argument_model.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/mixin/chapter_controller_mixin.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/mixin/comment_controller_mixin.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/mixin/theme_controller_mixin.dart';

class ReadNovelController extends GetxController
    with ChapterControllerMixin, ThemeControllerMixin, CommentControllerMixin {
  final TextEditingController commentController = TextEditingController();

  String? authID;

  ReadingBookCaseRequest readingBookReturn = ReadingBookCaseRequest();

  @override
  void onInit() {
    super.onInit();
    initScrollControllerMixin();
    initThemeControllerMixin();
    _initializeData();
  }

  void _initializeData() {
    var args = Get.arguments;
    if (args is NovelArgumentModel) {
      chaptersDisplay.value = args.chapterCurrent;
      listChapter = args.listChapter;
      _updateReadingProgress(args.bookId);
    } else if (args is Map<String, dynamic> &&
        args.containsKey("listChapter")) {
      listChapter = args["listChapter"];
    }
  }

  void _updateReadingProgress(String bookId) {
    readingBookReturn = ReadingBookCaseRequest(
      bookDataId: bookId,
      uid: authID ?? "",
      chapterName: chaptersDisplay.value.chapterName,
      readingDate: DateTime.now(),
      positionReading: 0,
    );
  }

  void toggleOverlayLayerVisibility() {
    isOverlayLayerVisible.toggle();
    double currentOffset = scrollController.position.pixels;
    for (int i = 0; i < chapterPositions.length; i++) {
      if (currentOffset >= (chapterPositions[i] ?? 0)) {
      } else {
        break;
      }
    }
    print("📖 Chương hiện tại: ${chaptersDisplay.value.chapterName}");
  }
}
