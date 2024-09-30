import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/expanded/book/presentation/layout_book_detail/layout_book_detail_page.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/novel_detail_controller.dart';

class NovelDetailPage extends GetView<NovelDetailController> {
  const NovelDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NovelDetailController>(
        id: "body",
        builder: (_) => LayoutBookDetailPage(
              thumbImage: controller.novelModel.thumbUrl,
              bookTitle: controller.novelModel.name,
              isLoading: controller.isLoading,
              listChapter: controller.listChapter,
            ));
  }
}
