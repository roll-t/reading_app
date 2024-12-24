
// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: camel_case_types
class wrapListRowWidget extends StatelessWidget {
  final String titleList;
  final int maxLength;
  final Widget Function(int indexCard) cardBuilder;
  final Function? seeMore;
  const wrapListRowWidget(
      {super.key,
      required this.titleList,
      required this.maxLength,
      required this.cardBuilder,
      this.seeMore});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Row(
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
        ),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 25.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: maxLength,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.only(left: 3.w),
                  child: cardBuilder(index));
            },
          ),
        ),
      ],
    );
  }
}
