// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/layout_shared_builder/book_detail/entities/models/info_book_detail_model.dart';
import 'package:reading_app/core/ui/layout_shared_builder/book_detail/entities/models/layout_book_detail_model.dart';
import 'package:reading_app/core/ui/layout_shared_builder/book_detail/presentation/page/layout_book_detail_page.dart';
import 'package:reading_app/features/novel/presentation/novel_detail/controllers/novel_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///**********************************
/// EDIT TIME - 20/03/2025
///
/// **USED IN:**
/// - ` novel features`
///
/// **EXPLANATION:**
///  writing description this heres.
///*********************************/

class NovelDetailPage extends GetView<NovelDetailController> {
  static String routeName = Routes.novelDetail;

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
                listComment: controller.listComment.value,
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
