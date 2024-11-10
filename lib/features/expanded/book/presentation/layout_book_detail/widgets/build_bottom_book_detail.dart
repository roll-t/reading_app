import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/book_case_data.dart';
import 'package:reading_app/core/data/database/model/chapter_novel_model.dart';
import 'package:reading_app/core/data/database/model/reading_book_case_model.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/data/sql/data_helper.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/features/expanded/book/model/info_comic_read_now_argument_model.dart';
import 'package:reading_app/features/expanded/comic/model/argument_comic_chapter_model.dart';
import 'package:reading_app/features/expanded/novel/model/novel_argument_model.dart';

class BuildBottomNavBookDetail extends StatelessWidget {
  final ReadingBookCaseResponse? bookCaseResponse;
  final ReadingComicBookCaseModel? readingComicBookCaseModel;
  final List<ChapterNovelModel>? listChapterNovel;
  final List<dynamic>? listChapterComic;
  final String? novelId;
  final InfoComicReadNowArgumentModel? infoComicReadNowArgumentModel;
  const BuildBottomNavBookDetail({
    super.key,
    this.bookCaseResponse,
    this.listChapterNovel,
    this.infoComicReadNowArgumentModel,
    this.readingComicBookCaseModel,
    this.novelId,
    this.listChapterComic,
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
                if (listChapterComic != null) {
                  ReadingComicBookCaseModel result = await Get.toNamed(
                    Routes.readBook,
                    arguments: ArgumentComicChapterModel(
                        currentChapter: readingComicBookCaseModel == null
                            ? (listChapterComic?[0])
                            : {
                                "filename":
                                    readingComicBookCaseModel?.comicName,
                                "chapter_name":
                                    readingComicBookCaseModel?.chapterName,
                                "chapter_title":
                                    readingComicBookCaseModel?.comicName,
                                "chapter_api_data":
                                    readingComicBookCaseModel?.chapterApiData,
                              },
                        listChapter: listChapterComic ?? [],
                        positionReading:
                            readingComicBookCaseModel?.positionReading),
                  );

                  final dbHelper = DatabaseHelper();
                  var token = await AuthUseCase.getAuthToken();
                  var auth = JwtDecoder.decode(token)["uid"];
                  result.uid = auth;

                  if (readingComicBookCaseModel != null) {
                    result.slug = readingComicBookCaseModel?.slug ?? "";
                    result.thumbUrl = readingComicBookCaseModel?.thumbUrl ?? "";
                    result.comicName =
                        readingComicBookCaseModel?.comicName ?? "";
                  } else {
                    result.slug = infoComicReadNowArgumentModel?.slug ?? "";
                    result.thumbUrl =
                        infoComicReadNowArgumentModel?.thumb ?? "";
                    result.comicName =
                        infoComicReadNowArgumentModel?.title ?? "";
                  }
                  dbHelper.insertReadingComic(result);
                }

                if (novelId != null) {
                  var result = bookCaseResponse != null
                      ? await Get.toNamed(Routes.readNovel, arguments: {
                          "readContinue": bookCaseResponse,
                          "listChapter": listChapterNovel
                        })
                      : await Get.toNamed(Routes.readNovel,
                          arguments: NovelArgumentModel(
                              bookId: listChapterNovel?[0].bookDataId ?? "",
                              chapterCurrent: listChapterNovel?[0] ??
                                  ChapterNovelModel(
                                      chapterId: "",
                                      chapterName: "",
                                      chapterTitle: "",
                                      chapterContent: "",
                                      createAt: DateTime.now(),
                                      bookDataId: ""),
                              listChapter: listChapterNovel ?? []));
                  if (result != null) {
                    if (result is ReadingBookCaseRequest) {
                      var data = result;
                      await BookCaseData.addReadingBookCase(request: data);
                    }
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
                    child: TextMediumSemiBold(
                  textChild: bookCaseResponse != null
                      ? "Đọc tiếp ${bookCaseResponse?.chapterName}"
                      : (readingComicBookCaseModel != null
                          ? "Đọc tiếp chương ${readingComicBookCaseModel?.chapterName}"
                          : AppContents.readNow),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
