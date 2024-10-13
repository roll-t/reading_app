import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/model/chapter_novel_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_light.dart';

// ignore: must_be_immutable
class BuildChapterNovelBody extends StatelessWidget {
  List<ChapterNovelModel> chapters;
  BuildChapterNovelBody({
    super.key,
    this.chapters = const <ChapterNovelModel>[],
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (_, index) {
          final ChapterNovelModel chapter = chapters[index];
          return InkWell(
            onTap: () async {
              Get.toNamed(Routes.readNovel, arguments: {
                'chapterCurrent': chapters[index],
                "listChapter": chapters
              });
            },
            child: ListTile(
              leading:
                  TextNormal(textChild: "${AppContents.chapter} ${index + 1}:"),
              title: Row(
                  children: [
                    Expanded(
                        child: TextNormal(
                      textChild:
                          "${chapter.chapterName != "" ? chapter.chapterTitle : chapter.createAt}",
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