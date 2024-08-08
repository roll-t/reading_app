import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/shared/icon_rounder.dart';

class BuildTagReact extends StatelessWidget {
  const BuildTagReact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3)),
          ],
          borderRadius: BorderRadius.circular(10),
          color: AppColors.black),
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.spaceStandard,
          vertical: SpaceDimens.space20),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              IconsRounder(iconData: Icons.remove_red_eye_outlined,),
              SizedBox(width: SpaceDimens.space10,),
              Column(
                children: [
                  TextSmall(
                    textChild: AppContents.read,
                    colorChild: AppColors.gray2,
                  ),
                  TextNormal(textChild: "78.3K")
                ],
              )
            ],
          ),
          Row(
            children: [
              const IconsRounder(iconData: Icons.thumb_up_alt_outlined,),
              const SizedBox(width: SpaceDimens.space10,),
              Column(
                children: [
                  const TextSmall(
                    textChild: AppContents.rating,
                    colorChild: AppColors.gray2,
                  ),
                  Row(
                    children: [
                      const TextNormal(textChild: "4.3"),
                      const SizedBox(width: 2,),
                      IconImage.iconImageNormal(iconUrl: AppIcons.iStar,size: IconsDimens.iconsSize18)
                    ],
                  )
                ],
              )
            ],
          ),
          const Row(
            children: [
              IconsRounder(iconData: Icons.list_alt,),
              SizedBox(width: SpaceDimens.space10,),
              Column(
                children: [
                  TextSmall(
                    textChild: AppContents.chapter,
                    colorChild: AppColors.gray2,
                  ),
                  TextNormal(textChild: "120")
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}