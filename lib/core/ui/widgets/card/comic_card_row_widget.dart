import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ComicCardRowWidget extends StatelessWidget {
  final String thumbUrl;
  final double? imageHeight;
  final double? imageWidth;
  final String slug;
  final String comicId;
  final String title;
  final String? category;

  const ComicCardRowWidget({
    super.key,
    required this.thumbUrl,
    required this.slug,
    required this.comicId,
    required this.title,
    this.category,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.comicDetail,
          arguments: {"slug": slug, "comicId": comicId},
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            SizedBox(
              width: imageWidth ?? 19.w,
              height: imageHeight ?? 19.h,
              child: ImageWidget(
                imageUrl: "https://img.otruyenapi.com/uploads/comics/$thumbUrl",
              ),
            ),
            const SizedBox(width: SpaceDimens.space10),

            // Text Section
            Expanded(
              child: SizedBox(
                height: imageHeight ?? 19.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: title,
                      size: TextDimens.textSize16,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                    ),
                    if (category?.isNotEmpty ?? false)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TagCategory(categoryName: category!),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
