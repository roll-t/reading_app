// Build category
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';

class BuildCategory extends StatelessWidget {
  const BuildCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: SpaceDimens.spaceStandard,
          right: SpaceDimens.spaceStandard,
          top: SpaceDimens.space25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconImage.iconImageSub(
              iconUrl: AppIcons.iRank, sub: AppContents.rank),
          IconImage.iconImageSub(
              iconUrl: AppIcons.iGold, sub: AppContents.gold),
          IconImage.iconImageSub(
              iconUrl: AppIcons.iStarBadge, sub: AppContents.selection),
          IconImage.iconImageSub(
              iconUrl: AppIcons.iFeatherPen, sub: AppContents.shortStory),
        ],
      ),
    );
  }
}
