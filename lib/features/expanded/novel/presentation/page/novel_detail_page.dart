import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/expanded/book/model/info_book_detail_model.dart';
import 'package:reading_app/features/expanded/book/presentation/layout_book_detail/layout_book_detail_page.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/novel_detail_controller.dart';

class NovelDetailPage extends GetView<NovelDetailController> {
  const NovelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NovelDetailController>(
        id: "body",
        builder: (_) => LayoutBookDetailPage(
              isLoading: controller.isLoading,
              lisComment: controller.listComment.value,
              categoriesNovel: controller.categories.value,
              listChapter: controller.listChapter,
              novelId: controller.novelModel.bookDataId,
              infoBookDetailModel: InfoBookDetailModel(
                bookTitle: controller.novelModel.name,
                thumbImage: controller.novelModel.thumbUrl,
                rating: 4.2,
                view: 1000,
                countChapter: controller.listChapter.length,
              ),
            ));
  }
}
