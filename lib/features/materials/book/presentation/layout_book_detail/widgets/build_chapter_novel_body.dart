import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/api/database/book_case_service.dart';
import 'package:reading_app/core/service/data/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_small_light.dart';
import 'package:reading_app/core/utils/date_time_utils.dart';
import 'package:reading_app/features/materials/novel/model/novel_argument_model.dart';

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
              var result = await Get.toNamed(Routes.readNovel,
                  arguments: NovelArgumentModel(
                      bookId: chapters[index].bookDataId,
                      chapterCurrent: chapters[index],
                      listChapter: chapters));
              if (result != null) {
                if (result is ReadingBookCaseRequest) {
                  await BookCaseData.addReadingBookCase(request: result);
                }
              }
            },
            child: ListTile(
              leading:TextNormal(textChild: "${AppContents.chapter} ${index + 1}:"),
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
                  TextSmallLight(
                    textChild: DatetimeUtil.formatCustom(chapter.createAt),
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
