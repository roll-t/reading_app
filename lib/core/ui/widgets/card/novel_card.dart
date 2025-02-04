import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/utils/string_utils.dart';

class NovelCard extends StatelessWidget {
  final double widthCard;
  final double heightImage;

  final NovelResponse bookModel;
  const NovelCard({
    super.key,
    required this.widthCard,
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
      child: Container(
        margin: const EdgeInsets.only(right: SpaceDimens.space10),
        width: widthCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: heightImage,
              child: ImageWidget(imageUrl: bookModel.thumbUrl ?? ""),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    textChild: bookModel.name ?? " ",
                    maxLinesChild: 2,
                  ),
                  if (bookModel.status != null && bookModel.status != "")
                    TagCategory(
                        categoryName: StringUtils.translate(
                            bookModel.status?.trim() ?? ""))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
