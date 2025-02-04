import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/data/entities/models/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/data/entities/models/layout_book_detail_model.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/presentation/page/layout_book_detail_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  const ComicDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: Image.asset(
                AppImages.iLoading,
                width: 35.w,
              ),
            )
          : LayoutBookDetailPage(
              layoutBookDetailModel: LayoutBookDetailModel(
                comicDetailController: controller,
                listComment: controller.listComment,
                comicId: controller.arguments.comicId,
                isLoading: controller.isLoading,
                listChapterComic: controller.chapters,
                categories: controller.category,
                infoBookDetailModel: InfoBookDetailModel(
                    bookTitle: controller.comicModel?.title ?? "",
                    thumbImage: controller.comicModel?.thumb ?? "",
                    description: controller.comicModel?.description ?? "",
                    countChapter: controller.chapters.length),
                listChapter: [],
              ),
            ),
    );
  }
}
