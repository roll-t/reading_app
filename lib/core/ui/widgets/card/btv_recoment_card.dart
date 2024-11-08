import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';

class BTVRecomentCard extends StatelessWidget {
  final double widthCard;
  final double heightImage;

  final ItemModel bookModel;
  final String domain;
  const BTVRecomentCard({
    super.key,
    required this.widthCard,
    required this.heightImage,
    required this.bookModel,
    required this.domain,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.bookDetail, arguments: {"slug": bookModel.slug});
      },
      child: Container(
        margin: const EdgeInsets.only(right: SpaceDimens.space10),
        width: widthCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: heightImage,
              child: ImageWidget(imageUrl: domain + bookModel.thumbUrl),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    textChild: bookModel.name,
                    maxLinesChild: 2,
                  ),
                  const TagCategory(categoryName: "Huyền thoại")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
