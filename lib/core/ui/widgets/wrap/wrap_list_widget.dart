// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: camel_case_types
class wrapListWidget extends StatelessWidget {
  final int maxLength;
  final String titleList;
  final int? maxCol;
  final Widget Function(int indexCard, double widthCard) cardBuilder;
  final Function? seeMore;

  const wrapListWidget({
    super.key,
    required this.maxLength,
    required this.titleList,
    required this.cardBuilder,
    this.maxCol,
    this.seeMore,
  });

  @override
  Widget build(BuildContext context) {
    final int columns = maxCol ?? 2;
    final double widthCard = (100.w - (6.w * (columns - 1))) / columns;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: titleList,
                size: TextDimens.textSize18,
                fontWeight: FontWeight.w500,
              ),
              if (seeMore != null)
                InkWell(
                  onTap: () => seeMore?.call(),
                  child: const Row(
                    children: [
                      TextWidget(
                        text: AppContents.seeMore,
                        size: TextDimens.textSize12,
                        color: AppColors.accentColor,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: TextDimens.textSize12,
                        color: AppColors.accentColor,
                      )
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          if (maxLength > 0)
            SizedBox(
              width: 100.w,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 3.w,
                runSpacing: 3.w,
                children: List.generate(maxLength, (index) {
                  return cardBuilder(index, widthCard);
                }),
              ),
            )
          else
            const Center(
              child: TextWidget(
                text: "No items available",
                size: TextDimens.textSize16,
                color: AppColors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
