import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';

class TagCategory extends StatelessWidget {
  final String categoryName;
  final TagMarker typeTag;
  final VoidCallback? onTap;

  const TagCategory({
    super.key,
    required this.categoryName,
    this.typeTag = TagMarker.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayCategory = categoryName.split(" | ").first;

    final Map<TagMarker, Map<String, dynamic>> tagStyles = {
      TagMarker.newUpdate: {
        'color': AppColors.tagNewUpdate,
        'image': AppIcons.iFlash,
        'textColor': AppColors.black,
      },
      TagMarker.justPosted: {
        'color': AppColors.tagJustPosted,
        'image': AppIcons.iPeaceSign,
        'textColor': AppColors.black,
      },
      TagMarker.trending: {
        'color': AppColors.tagTrending,
        'image': AppIcons.iFire,
        'textColor': AppColors.gray1,
      },
    };

    final tagStyle = tagStyles[typeTag] ??
        {
          'color': AppColors.tertiaryDarkBg,
          'image': null,
          'textColor': AppColors.gray1,
        };

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: SpaceDimens.space5, horizontal: SpaceDimens.space10),
        decoration: BoxDecoration(
            color: tagStyle['color'], borderRadius: BorderRadius.circular(5)),
        child: FittedBox(
          child: Row(
            children: [
              tagStyle['image'] != null
                  ? Image.asset(
                      tagStyle['image']!,
                      width: IconsDimens.iconsSize18,
                      height: IconsDimens.iconsSize18,
                    )
                  : const SizedBox(),
              const SizedBox(width: SpaceDimens.space5),
              TextSmall(
                textChild: displayCategory,
                colorChild: tagStyle['textColor'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
