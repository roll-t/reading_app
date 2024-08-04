import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';

class BTVRecomentCard extends StatelessWidget {
  final double widthCard;
  final double heightImage;
  final BookModel bookModel;

  const BTVRecomentCard({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightImage,
            child: ImageWidget(imageUrl:bookModel.imageUrl),
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
                const TagCategory(categoryName: "Huyền thoại")
              ],
            ),
          )
        ],
      ),
    );
  }
}
