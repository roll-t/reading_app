import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/materials/book/comic/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/book/layout_book_detail/data/model/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book/layout_book_detail/presentation/page/layout_book_detail_page.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  const ComicDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComicDetailController>(
      id: "body",
      builder: (_) => controller.isComicAvAilable.value
          ? LayoutBookDetailPage(
            comicDetailController: controller,
              lisComment: controller.listComment,
              comicId: controller.argumentComicId,
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
            )
          : Scaffold(
              appBar: AppBar(
                leading: const leadingIconAppBar(),
              ),
              body: const Center(
                child: Text("Nâng cấp tài khoản để đọc tiếp"),
              ),
            ),
    );
  }
}
