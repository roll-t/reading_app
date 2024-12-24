import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/utils/string_utils.dart';

class CardRowWidget extends StatelessWidget {
  final int currentIndex;
  final double heightImage;
  final ItemModel bookModel;
  final bool last;

  const CardRowWidget({
    super.key,
    required this.heightImage,
    required this.bookModel,
    required this.currentIndex,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.comicDetail,
            arguments: {"slug": bookModel.slug, "comicId": bookModel.id});
      },
      child: Container(
        height: heightImage + SpaceDimens.space25,
        width: Get.width,
        margin: currentIndex != 0
            ? const EdgeInsets.only(top: SpaceDimens.space15)
            : null,
        padding: const EdgeInsets.only(bottom: SpaceDimens.space15),
        decoration: BoxDecoration(
            border: !last
                ? const Border(
                    bottom: BorderSide(color: AppColors.gray3, width: .5))
                : null),
        child: Row(
          children: [
            SizedBox(
                width: heightImage,
                height: heightImage,
                child: ImageWidget(
                    imageUrl:
                        "https://img.otruyenapi.com/uploads/comics/${bookModel.thumbUrl}")),
            const SizedBox(
              width: SpaceDimens.space15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: bookModel.name,
                    size: TextDimens.textSize16,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  TagCategory(
                      categoryName:
                          StringUtils.translate(bookModel.status.trim()))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
