import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/expanded/book/model/info_book_detail_model.dart';
import 'package:reading_app/features/expanded/book/presentation/layout_book_detail/layout_book_detail_page.dart';
import 'package:reading_app/features/expanded/comic/presentation/controllers/comic_detail_controller.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  const ComicDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComicDetailController>(
      id: "body",
      builder: (_) => LayoutBookDetailPage(
        isLoading: controller.isLoading,
        listChapterComic: controller.chapters,
        categories: controller.category,
        infoBookDetailModel: InfoBookDetailModel(
            bookTitle: controller.comicModel.title,
            thumbImage: controller.comicModel.thumb,
            description: controller.comicModel.description,
            rating: 4.3,
            view: 10000,
            countChapter: controller.chapters.length),
      ),
    );
  }
}
