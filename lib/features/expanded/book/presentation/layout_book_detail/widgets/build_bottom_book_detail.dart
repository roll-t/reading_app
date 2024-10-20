import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/book_case_data.dart';
import 'package:reading_app/core/data/database/model/chapter_novel_model.dart';
import 'package:reading_app/core/data/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';

class BuildBottomNavBookDetail extends StatelessWidget {
  final ReadingBookCaseResponse? bookCaseResponse;
  final List<ChapterNovelModel>? listChapterNovel;
  const BuildBottomNavBookDetail({
    super.key,
    this.bookCaseResponse,
    this.listChapterNovel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SpaceDimens.space5, horizontal: SpaceDimens.spaceStandard),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: SpaceDimens.space10,
            children: [
              Container(
                padding: const EdgeInsets.all(SpaceDimens.space5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.gray3),
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull)),
                child: const Icon(Icons.download),
              ),
              Container(
                padding: const EdgeInsets.all(SpaceDimens.space5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.gray3),
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull)),
                child: const Icon(Icons.favorite_border_sharp),
              ),
            ],
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                var result = await Get.toNamed(Routes.readNovel, arguments: {
                  "readContinue": bookCaseResponse,
                  "listChapter": listChapterNovel
                });
                if (result != null) {
                  if (result is ReadingBookCaseRequest) {
                    var data = result;
                    await BookCaseData.addReadingBookCase(request: data);
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: SpaceDimens.space20),
                padding:
                    const EdgeInsets.symmetric(horizontal: SpaceDimens.space30),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull),
                    color: AppColors.accentColor),
                height: 50,
                child: Center(
                    child: TextLargeSemiBold(
                  textChild: bookCaseResponse == null
                      ? AppContents.readNow
                      : "Đọc tiếp ${bookCaseResponse?.chapterName ?? ""}",
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
