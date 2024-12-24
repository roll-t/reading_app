import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ComicCardWidget extends StatelessWidget {
  final String thumbUrl;
  final String comicTitle;
  final double? width;
  final String? slug;
  final double? heightImage;
  final String? comicId;
  const ComicCardWidget(
      {super.key,
      required this.thumbUrl,
      required this.comicTitle,
      this.width,
      this.heightImage,
      this.slug,
      this.comicId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.comicDetail,
            arguments: {"slug": slug, "comicId": comicId});
      },
      child: SizedBox(
        width: width ?? 29.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
                height: heightImage ?? 19.h,
                imageUrl:
                    "https://img.otruyenapi.com/uploads/comics/$thumbUrl"),
            SizedBox(
              height: .5.h,
            ),
            TextWidget(
              text: comicTitle,
              size: TextDimens.textSize14,
              maxLines: 2,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
