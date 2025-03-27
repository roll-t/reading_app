import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/storage/sql/data_helper.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_small_light.dart';
import 'package:reading_app/features/auth/domain/usecase/auth_use_case.dart';
import 'package:reading_app/features/comic/data/entities/arguments/comic_chapter_argument.dart';
import 'package:reading_app/features/comic/presentation/comic_detail/controllers/comic_detail_controller.dart';

// ignore: must_be_immutable
class BuildChapterComicBody extends StatelessWidget {
  final List<dynamic> listChapterComic;
  ComicDetailController? controller;
  BuildChapterComicBody({
    super.key,
    this.controller,
    required this.listChapterComic,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listChapterComic.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () async {
              ReadingComicBookCaseModel result = await Get.toNamed(
                  Routes.readBook,
                  arguments: ComicChapterArgument(
                      currentChapter: listChapterComic[index],
                      listChapter: listChapterComic));
              if (result.chapterApiData != "") {
                final dbHelper = DatabaseHelper();
                var token = await AuthUseCase.getAuthToken();
                var auth = JwtDecoder.decode(token)["uid"];
                result.slug = controller?.arguments.slug ?? "";
                result.thumbUrl = controller?.comicModel?.thumb ?? "";
                result.comicName = controller?.comicModel?.title ?? "";
                result.uid = auth;
                dbHelper.insertReadingComic(result);
              }
            },
            child: ListTile(
              leading:
                  TextNormal(textChild: "${AppContents.chapter} ${index + 1}:"),
              title: Row(
                children: [
                  Expanded(
                      child: TextNormal(
                    textChild:
                        "${listChapterComic[index]["chapter_title"] != "" ? listChapterComic[index]["chapter_title"] : listChapterComic[index]["filename"]}",
                    maxLinesChild: 1,
                  )),
                  const SizedBox(
                    width: AppDimens.space10,
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
