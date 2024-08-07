import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

class BuildBodyList extends StatelessWidget {
  final Widget childBuilder;
  final String? titleList;
  final VoidCallback? seeMore;
  const BuildBodyList({
    super.key,
    required this.childBuilder,
    required this.titleList,
    this.seeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryDarkBg,
      ),
      child: Wrap(
        runSpacing: SpaceDimens.space15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLargeSemiBold(textChild: titleList ?? ""),
              seeMore != null
                  ? InkWell(
                      onTap: seeMore,
                      child: const TextNormal(
                        textChild: AppContents.seeMore,
                        colorChild: AppColors.accentColor,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          childBuilder
        ],
      ),
    );
  }
}
