import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardReadingContinue extends StatelessWidget {
  final double widthCard;
  final double heigthShadownContentChapter;
  final ReadingBookCaseResponse bookCaseModel;

  const CardReadingContinue({
    super.key,
    required this.widthCard,
    this.heigthShadownContentChapter = 60,
    required this.bookCaseModel,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.novelDetail, arguments: {
          "novelId": bookCaseModel.bookData.bookDataId,
          "readContinue": bookCaseModel
        });
      },
      child: Container(
          padding: const EdgeInsets.only(right: SpaceDimens.space10),
          width: widthCard,
          child: Stack(
            children: [
              SizedBox(
                  child:
                      ImageWidget(imageUrl: bookCaseModel.bookData.thumbUrl)),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: heigthShadownContentChapter,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          AppColors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(SpaceDimens.space5 - 1),
                  decoration: const BoxDecoration(
                      color: AppColors.tertiaryDarkBg,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                  child: TextSmall(
                    maxLinesChild: 1,
                    textChild: bookCaseModel.bookData.name,
                  ),
                ),
              ),
              Positioned(
                left: SpaceDimens.space5,
                bottom: TextDimens.textNormal + SpaceDimens.space15,
                child: TextNormal(
                  textChild: bookCaseModel.chapterName,
                  colorChild: AppColors.white,
                ),
              ),
            ],
          )),
    );
  }
}
