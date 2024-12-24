import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NovelCardWidget extends StatelessWidget {
  final String thumbUrl;
  final String novelTitle;
  final double? width;
  final String? slug;
  final String? novelId;
  final double? heightImage;
  
  const NovelCardWidget(
      {super.key,
      required this.thumbUrl,
      required this.novelTitle,
      this.width,
      this.heightImage,
      this.slug,
      this.novelId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.novelDetail, arguments: {"novelId": novelId});
      },
      child: SizedBox(
        width: width ?? 29.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(height: heightImage ?? 19.h, imageUrl: thumbUrl),
            SizedBox(
              height: .5.h,
            ),
            TextWidget(
              text: novelTitle,
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
