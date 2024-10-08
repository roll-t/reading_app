import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_light.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';

class BuildChapterBody extends StatelessWidget {
  final BookDetailController controller;
  const BuildChapterBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.chapters.length,
        itemBuilder: (_, index) {
          return InkWell (
            onTap: ()async{ Get.toNamed(Routes.readBook,arguments:  controller.chapters[index]);},
            child: ListTile(
              leading:
                  TextNormal(textChild: "${AppContents.chapter} ${index + 1}:"),
              title: Row(
                children: [
                  Expanded(
                      child: TextNormal(
                    textChild:
                        "${controller.chapters[index]["chapter_title"] != "" ? controller.chapters[index]["chapter_title"] : controller.chapters[index]["filename"]}",
                    maxLinesChild: 1,
                  )),
                  const SizedBox(
                    width: SpaceDimens.space10,
                  ),
                  const TextSmallLight(
                    textChild: "11/02/2024",
                    colorChild: AppColors.gray2,
                    maxLinesChild: 1,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
