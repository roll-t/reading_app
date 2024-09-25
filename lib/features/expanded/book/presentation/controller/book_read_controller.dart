import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/comic_api.dart';
import 'package:reading_app/core/services/data/model/chapter_model.dart';

class BookReadController extends GetxController {
  
  ChapterModel? chapterModel;

  List<dynamic> listChapterImage = [];

  var imageUrls = <String>[].obs;

  var loading = false.obs;

  var page = 0.obs;
  
  final int pageSize = 5;

  final ScrollController scrollController = ScrollController();

  dynamic arguments;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
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

  void scrollDown() {
    scrollController.animateTo(
      scrollController.offset + Get.height * .4,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> fetchBookImages() async {
    if (arguments != null) {
      final result = await ComicApi.getChapterDataAPI(chapter: arguments);
      if (result.status == Status.success) {
        chapterModel = result.data;
        loadMoreImages();
      }
    }
  }

  void loadMoreImages() {

    loading.value = true;

    if(chapterModel==null) return;

    int startIndex = page.value * pageSize;

    int endIndex = (page.value + 1) * pageSize;

    endIndex = endIndex > chapterModel!.chapterImages.length - 1
        ? chapterModel!.chapterImages.length
        : endIndex;

    List<String> newImages = [];

    for (int i = startIndex; i < endIndex; i++) {
      var urlResult = "${chapterModel!.domain}/${chapterModel!.chapterPath}/${chapterModel!.chapterImages[i].imageFile}";
      newImages.add(urlResult);
    }


    imageUrls.addAll(newImages);
    
    print(imageUrls.length);

    page.value++;
    loading.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
