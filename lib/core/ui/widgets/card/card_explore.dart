import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';

class CardExplore extends StatelessWidget {
  final double widthCard;
  final double heightCard;
  final BookModel bookModel;

  const CardExplore({
    super.key,
    required this.widthCard,
    required this.heightCard,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightCard,
      width: widthCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightCard * .65,
            child: ImageWidget(imageUrl: bookModel.imageUrl),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: SpaceDimens.space5,),
              TextSmall(
                textChild: bookModel.title,
                maxLinesChild: 2,
              ),
              const Spacer(),
              const TextSmall(
                textChild: "30 ${AppContents.chapter}",
                colorChild: AppColors.gray2,
                maxLinesChild: 2,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
