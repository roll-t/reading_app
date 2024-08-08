

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';

class BuildWrapListComment extends StatelessWidget {
  final double heightWrapList;
  final String? titleList;
  final double widthCard;
  final EdgeInsetsGeometry margin;
  final VoidCallback ? toDetail;
   final Axis scrollDirection; // New parameter for scroll direction
  

  const BuildWrapListComment({
    super.key,
    required this.heightWrapList,
    this.titleList, 
    required this.widthCard, 
    this.margin = const EdgeInsets.only(top: SpaceDimens.space20), 
    this.toDetail, 
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: titleList != null
          ? heightWrapList + SpaceDimens.space10 + TextDimens.textLarge
          : heightWrapList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleList != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: SpaceDimens.spaceStandard, bottom: SpaceDimens.space10),
                  child: TextMediumSemiBold(textChild: titleList!),
                ),
                if(toDetail!=null)
                Padding(
                  padding: const EdgeInsets.only(
                      right: SpaceDimens.spaceStandard, bottom: SpaceDimens.space10),
                  child: InkWell( onTap:toDetail,child: const 
                  Row(children: [
                    TextSmall(textChild: "2 ${AppContents.comment}",colorChild: AppColors.gray2),
                    Icon(Icons.arrow_forward_ios_rounded,size: IconsDimens.iconsSize18,color: AppColors.gray2,)
                  ],)
                  ),
                ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: ListView.builder(
                scrollDirection: scrollDirection,
                itemCount:10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: SpaceDimens.space20),
                    decoration: BoxDecoration(color: AppColors.tertiaryDarkBg,borderRadius: BorderRadius.circular(10)),
                    width: 300,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
