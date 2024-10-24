import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardNewestUpdate extends StatelessWidget {
  final double heightImage;
  final ItemModel bookModel;
  final String domainImage;
  const CardNewestUpdate({
    super.key,
    required this.heightImage,
    required this.bookModel,
    required this.domainImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.comicDetail, arguments: {"slug": bookModel.slug});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightImage,
            child: ImageWidget(imageUrl: domainImage + bookModel.thumbUrl),
          ),
          const SizedBox(
            height: SpaceDimens.space5,
          ),
          Expanded(
            child: TextNormal(
              textChild: bookModel.name,
              maxLinesChild: 2,
            ),
          ),
        ],
      ),
    );
  }
}
