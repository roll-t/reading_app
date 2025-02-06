import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildTagReact extends StatelessWidget {
  final String title;
  final int countChapters;
  final int? countView;
  final double? rating;

  const BuildTagReact({
    super.key,
    required this.title,
    required this.countChapters,
    this.countView,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.w),
          padding: EdgeInsets.only(left: 4.w, top: 4.w, right: 4.w, bottom: 8.w),
          width: 100.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: AppColors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
            ],
          ),
        ),
        Positioned(
            bottom: 2.5.w,
            right: 3.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RadiusDimens.radiusFull),
                  color: AppColors.primary),
              child: TextWidget(
                  color: AppColors.gray1,
                  size: TextDimens.textSize14,
                  text: "$countChapters Chương"),
            ))
      ],
    );
  }

  Widget _buildTitle() {
    return TextWidget(
      text: title,
      maxLines: 3,
      size: TextDimens.textSize18,
      fontWeight: FontWeight.w500,
    );
  }
}
