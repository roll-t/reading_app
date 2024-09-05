

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/models/list_comic_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardReadingContinue extends StatelessWidget {
  final double widthCard;
  final String? chapter;
  final double heigthShadownContentChapter;
  final String domain;
  final ItemModel bookModel;


  const CardReadingContinue({
    super.key,
    this.chapter,
    required this.widthCard,
    this.heigthShadownContentChapter = 60, 
    required this.bookModel, 
    required this.domain,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: SpaceDimens.space10),
        width: widthCard,
        child: Stack(
          children: [
            SizedBox(child: ImageWidget(imageUrl:domain+bookModel.thumbUrl)),
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
                child: TextNormal(
                  maxLinesChild: 1,
                  textChild: bookModel.name,
                ),
              ),
            ),
            Positioned(
              left: SpaceDimens.space5,
              bottom: TextDimens.textNormal + SpaceDimens.space15,
              child: TextNormal(
                textChild: chapter ?? "",
                colorChild: AppColors.white,
              ),
            ),
          ],
        ));
  }
}

