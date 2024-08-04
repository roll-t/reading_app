import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardByCategory extends StatelessWidget {
  final double widthCard;
  final double heightImage;
  final BookModel bookModel;
  const CardByCategory({
    super.key,
    required this.widthCard,
    required this.heightImage,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: SpaceDimens.space10),
      width: widthCard,
      child: Column(
        children: [
          SizedBox(
            height: heightImage,
            child: ImageWidget(
              imageUrl: bookModel.imageUrl,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextNormal(
                  textChild: bookModel.title,
                  maxLinesChild: 2,
                ),
                TextSmall(
                  textChild:bookModel.description??AppContents.updating,
                  colorChild: AppColors.gray1,
                  maxLinesChild: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
