import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/data/entities/models/info_book_detail_model.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/data/entities/models/layout_book_detail_model.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/presentation/page/layout_book_detail_page.dart';
import 'package:reading_app/features/content/book_details/novels/presentation/controller/novel_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NovelDetailPage extends GetView<NovelDetailController> {
  const NovelDetailPage({super.key});

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
                uid: controller.authId,
                novelDetailController: controller,
                isLoading: controller.isLoading,
                // ignore: invalid_use_of_protected_member
                listComment: controller.listComment.value,
                // ignore: invalid_use_of_protected_member
                categoriesNovel: controller.categories.value,
                listChapter: controller.listChapter,
                novelId: controller.novelModel.bookDataId,
                infoBookDetailModel: InfoBookDetailModel(
                  bookTitle: controller.novelModel.name,
                  thumbImage: controller.novelModel.thumbUrl,
                  countChapter: controller.listChapter.length,
                ),
              ),
            ),
    );
  }
}
