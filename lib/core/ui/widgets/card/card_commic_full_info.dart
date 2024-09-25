

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/data/model/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';

class CardCommicFullInfo extends StatelessWidget {
  final int currentIndex;
  final double heightImage;
  final double widthImage;
  final BookModel bookModel;

  const CardCommicFullInfo({
    super.key, 
    required this.heightImage,
    required this.bookModel, 
    required this.currentIndex, 
    required this.widthImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightImage ,
      width: Get.width,
      child: Row(
        children: [
          SizedBox(
            width: widthImage,
            height: heightImage,
            child: ImageWidget(
                imageUrl:bookModel.imageUrl),
          ),
          const SizedBox(
            width: SpaceDimens.space10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextNormal(textChild:bookModel.title),
                const SizedBox(height: SpaceDimens.space10,),
                TextSmall(
                  textChild: bookModel.description ?? AppContents.updating,
                  maxLinesChild: 3,
                  colorChild: AppColors.gray2,),
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    TextSmall(textChild: "340 ${AppContents.chapter}",colorChild: AppColors.gray1,),
                    TagCategory(categoryName: "Huyền Thoại")
                  ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}
