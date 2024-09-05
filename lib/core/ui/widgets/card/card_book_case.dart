

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardBookCase extends StatelessWidget {
  final String type;
  final BookModel bookModel;
  final double heightCard;
  final double widthCard;
  const CardBookCase({
    super.key, 
    required this.type, 
    required this.bookModel, 
    required this.heightCard, 
    required this.widthCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      child: Container(
        height: heightCard,
        margin: const EdgeInsets.symmetric(
            horizontal: SpaceDimens.spaceStandard,
            vertical: SpaceDimens.space10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryDarkBg),
        child: Row(
          children: [
            SizedBox(
              height: heightCard,
              width: widthCard,
              child: ImageWidget(
                imageUrl:bookModel.imageUrl,
              ),
            ),
            const SizedBox(
              width: SpaceDimens.space10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: SpaceDimens.space5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSmallSemiBold(textChild:type),
                    const SizedBox(height: SpaceDimens.space5,),
                    TextNormal(
                      textChild:bookModel.title,
                      maxLinesChild: 2,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SpaceDimens.space10,
                          vertical: SpaceDimens.space5),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(1000),
                          color: AppColors.accentColor
                              .withOpacity(.5)),
                      child: const TextNormal(
                        textChild:
                            "${AppContents.chapter} 2/12",
                      ),
                    ),
                    const SizedBox(
                      width: SpaceDimens.space10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: SpaceDimens.space10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(SpaceDimens.space10),
                  child: Icon(Icons.delete,color: AppColors.gray2,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
