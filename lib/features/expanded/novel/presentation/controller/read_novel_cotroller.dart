import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/database/data/model/chapter_novel_model.dart';

class ReadNovelCotroller extends GetxController {
  ChapterNovelModel chapterNovelModel = DefaultData.defaultChapter;
  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments['chapterCurrent'] is ChapterNovelModel) {
        chapterNovelModel = Get.arguments['chapterCurrent'];
      }
      if (Get.arguments['listChapter'] is List<ChapterNovelModel>) {
        listChapter = Get.arguments['listChapter'];
      }

    }
  }

  // Hàm cuộn lên
  void scrollUp() {
    scrollController.animateTo(
      scrollController.position.pixels - 230, // Cuộn lên 100 pixels
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  // Hàm cuộn xuống
  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.pixels + 230, // Cuộn xuống 100 pixels
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }
}
