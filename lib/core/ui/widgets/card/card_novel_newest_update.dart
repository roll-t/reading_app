import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardNovelNewestUpdate extends StatelessWidget {
  final double heightImage;
  final NovelResponse bookModel;
  const CardNovelNewestUpdate({
    super.key,
    required this.heightImage,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.novelDetail,
            arguments: {"novelId": bookModel.bookDataId});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightImage,
            child: ImageWidget(imageUrl: bookModel.thumbUrl ?? ""),
          ),
          const SizedBox(
            height: SpaceDimens.space5,
          ),
          Expanded(
            child: TextNormal(
              textChild: bookModel.name ?? "",
              maxLinesChild: 2,
            ),
          ),
        ],
      ),
    );
  }
}
