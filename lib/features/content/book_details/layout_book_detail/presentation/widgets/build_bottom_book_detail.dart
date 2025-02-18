import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/book_case_service.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/core/storage/sql/data_helper.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/features/content/book_details/comics/comic_detail/data/model/argument_comic_chapter_model.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/data/entities/arguments/info_comic_read_now_argument.dart';
import 'package:reading_app/features/content/book_details/novel_detail/model/novel_argument_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildBottomNavBookDetail extends StatelessWidget {
  final String? uid;
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
    this.uid,
  });

  Future<bool> checkIfBookLiked(BookCaseService bookCaseData) async {
    if (novelId != null && uid != null) {
      var response = await bookCaseData.checkIfBookLiked(
        bookDataId: novelId!,
        userId: uid!,
      );
      if (response.status == Status.success) {
        return response.data ?? false;
      }
    }
    return false;
  }

  void toggleFavorite(
    BookCaseService bookCaseData,
    RxBool isFavorite,
    RxBool isLoading,
  ) async {
    if (uid != null && novelId != null) {
      isLoading.value = true;
      await bookCaseData.toggleLikeBook(
        bookDataId: novelId ?? "",
        userId: uid ?? "",
      );
      isFavorite.value = !isFavorite.value;
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    BookCaseService bookCaseData = Get.find();
    RxBool isFavorite = false.obs;
    RxBool isLoading = false.obs;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpaceDimens.space5,
        horizontal: SpaceDimens.spaceStandard,
      ),
      child: Row(
        mainAxisAlignment: novelId != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          novelId != null
              ? Wrap(
                  spacing: SpaceDimens.space10,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(SpaceDimens.space5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.gray3),
                        borderRadius:
                            BorderRadius.circular(RadiusDimens.radiusFull),
                      ),
                      child: FutureBuilder<bool>(
                        future: checkIfBookLiked(bookCaseData),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return const Icon(Icons.error,
                                color: AppColors.accentColor);
                          }
                          if (snapshot.hasData) {
                            isFavorite.value = snapshot.data ?? false;
                            return Obx(() {
                              return InkWell(
                                onTap: () => toggleFavorite(
                                    bookCaseData, isFavorite, isLoading),
                                child: isLoading.value
                                    ? const CircularProgressIndicator()
                                    : isFavorite.value
                                        ? const Icon(Icons.favorite,
                                            color: AppColors.accentColor)
                                        : const Icon(
                                            Icons.favorite_border_sharp),
                              );
                            });
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          Expanded(
            child: InkWell(
              onTap: () async {
                if (listChapterComic != null) {
                  final result = await Get.toNamed(
                    Routes.readBook,
                    arguments: ArgumentComicChapterModel(
                      currentChapter: readingComicBookCaseModel == null
                          ? listChapterComic![0]
                          : {
                              "filename": readingComicBookCaseModel?.comicName,
                              "chapter_name":
                                  readingComicBookCaseModel?.chapterName,
                              "chapter_title":
                                  readingComicBookCaseModel?.comicName,
                              "chapter_api_data":
                                  readingComicBookCaseModel?.chapterApiData,
                            },
                      listChapter: listChapterComic ?? [],
                      positionReading:
                          readingComicBookCaseModel?.positionReading,
                    ),
                  );

                  if (result != null) {
                    final dbHelper = DatabaseHelper();
                    var token = await AuthUseCase.getAuthToken();
                    var auth = JwtDecoder.decode(token)["uid"];
                    result.uid = auth;

                    if (readingComicBookCaseModel != null) {
                      result.slug = readingComicBookCaseModel?.slug ?? "";
                      result.thumbUrl =
                          readingComicBookCaseModel?.thumbUrl ?? "";
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
                }

                if (novelId != null) {
                  var result = bookCaseResponse != null
                      ? await Get.toNamed(Routes.readNovel, arguments: {
                          "readContinue": bookCaseResponse,
                          "listChapter": listChapterNovel,
                        })
                      : await Get.toNamed(Routes.readNovel,
                          arguments: NovelArgumentModel(
                            bookId: listChapterNovel?[0].bookDataId ?? "",
                            chapterCurrent:
                                listChapterNovel?[0] ?? ChapterNovelModel(),
                            listChapter: listChapterNovel ?? [],
                          ));
                  if (result != null && result is ReadingBookCaseRequest) {
                    // Handle case where result is of type ReadingBookCaseRequest
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: novelId != null ? 5.w : 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: SpaceDimens.space30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RadiusDimens.radiusFull),
                  color: AppColors.accentColor,
                ),
                height: 50,
                child: Center(
                  child: TextMediumSemiBold(
                    textChild: bookCaseResponse != null
                        ? "Đọc tiếp ${bookCaseResponse?.chapterName}"
                        : (readingComicBookCaseModel != null
                            ? "Đọc tiếp chương ${readingComicBookCaseModel?.chapterName}"
                            : AppContents.readNow),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
