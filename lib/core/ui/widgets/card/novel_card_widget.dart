import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class NovelCardWidget extends StatelessWidget {
  final String thumbUrl;
  final String novelTitle;
  final double? width;
  final String? slug;
  final String? novelId;
  final double? heightImage;
  final bool isLoading;

  const NovelCardWidget({
    super.key,
    required this.thumbUrl,
    required this.novelTitle,
    this.width,
    this.heightImage,
    this.slug,
    this.novelId,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          Get.toNamed(Routes.novelDetail, arguments: {"novelId": novelId});
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
                      height: heightImage ?? 18.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                    ),
                  )
                : ImageWidget(
                    height: heightImage ?? 18.h,
                    imageUrl: thumbUrl,
                  ),
            SizedBox(height: 1.h),
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
                          height: 1.w,
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 1.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          height: 1.w,
                          width: 15.w,
                        ),
                      ],
                    ),
                  )
                : TextWidget(
                    text: novelTitle,
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
