import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ComicCardWidget extends StatelessWidget {
  final String thumbUrl;
  final String comicTitle;
  final double? width;
  final String? slug;
  final double? heightImage;
  final String? comicId;
  final bool isLoading;

  const ComicCardWidget({
    super.key,
    required this.thumbUrl,
    required this.comicTitle,
    this.width,
    this.heightImage,
    this.slug,
    this.comicId,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          Get.toNamed(Routes.comicDetail,
              arguments: {"slug": slug, "comicId": comicId});
        }
      },
      child: SizedBox(
        width: width ?? 29.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? Shimmer.fromColors(
                    baseColor: AppColors.shimmerBase,
                    highlightColor: AppColors.shimmerHighlight,
                    child: Container(
                      height: heightImage ?? 19.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                    ),
                  )
                : ImageWidget(
                    height: heightImage ?? 19.h,
                    imageUrl:
                        "https://img.otruyenapi.com/uploads/comics/$thumbUrl"),
            SizedBox(
              height: 2.w,
            ),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: AppColors.shimmerBase,
                    highlightColor: AppColors.shimmerHighlight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          width: 20.w,
                          height: 1.w,
                        ),
                        SizedBox(
                          height: 1.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          width: 15.w,
                          height: 1.w,
                        )
                      ],
                    ),
                  )
                : TextWidget(
                    text: comicTitle,
                    size: TextDimens.textSize14,
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                  ),
          ],
        ),
      ),
    );
  }
}
